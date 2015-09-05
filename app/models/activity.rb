# == Schema Information
#
# Table name: activities
#
#  id         :integer          not null, primary key
#  project_id :integer
#  task_id    :integer
#  subtask_id :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  start      :datetime
#  ended      :datetime
#  duration   :decimal(, )
#

class Activity < ActiveRecord::Base
  belongs_to :project
  belongs_to :task
  belongs_to :subtask
  belongs_to :user

  validates :project_id, presence: true
  validates :task_id, presence: true
  validates :user_id, presence: true
  validates :start, presence: true

  scope :with_end, -> { where.not( ended: nil) }
  scope :for_project, -> (id) { where(project_id: id) }
  scope :for_task, -> (id) { where(task_id: id) }
  scope :for_user, -> (id) { where(user_id: id) }

  scope :ordered_last_first, -> { order('start DESC, project_id ASC, task_id ASC, user_id ASC') }

  paginates_per 15

  before_save :calc_duration

  def calc_duration
    # binding.pry
  	if self.ended && self.start
      self.duration = self.ended - self.start
    else
      0
  	end
  end

  # EXECUTE IMPORT
  # 
  # Expected hash
  # line = { "line_num": counter, "proj": proj, "task": task, "subtask": subtask, "start": start, "ended": ended, "duration": duration, "invalid": true, 
  #     "objects": line_objects })
  def self.execute_import(uid, parsed_lines)
    result = []
    counter = 0
    parsed_lines.each do |line|
      project_id = line[:objects][:proj].id
      task_id = line[:objects][:task].id
      subtask_id = line[:objects][:subtask].blank? ? nil : line[:objects][:subtask].id
      user_id = uid
      start = line[:start]
      ended = line[:ended]
      duration = line[:duration]
      # result << { "proj": project_id, "task": task_id, "subtask": subtask_id, "user": user_id, "start": start, "ended": ended, "duration": duration }
      Activity.create({ project_id: project_id, task_id: task_id, subtask_id: subtask_id, user_id: user_id, start: start.getutc, ended: ended, duration: duration })
      counter += 1
    end
    counter
  end

  # PARSE TEXT FILE WITH ACTIVITY LINES
  # 
  def self.read_activity_file(filename)
    parsed_lines = []
    File.foreach(filename.path).with_index do |line, index|
      parsed_lines << self.parse_file_line(line, index) unless line.start_with?"#","\n"
    end
    parsed_lines.flatten!
  end

  private

  # TODO extract subtasks and add to subtasks table if new
  # # sintaxis
  # # DD/MM[YY default current] PROJ [TASK default prog [SUBTASK]] HH:MM-HH:MM [HH:MM-HH:MM] [HH:MM-HH:MM] ...
  # ## PROJ name or alias, case insensitive
  # ## HH:MM-HH:MM start-end

  # Example
  # 16/6 shk prog 20:00-5:00
  # 17/6 shk prog 11:30-14:00 15:00-18:00
  def self.parse_file_line(line, counter)

    default_task = "prog"
    result = []

    elements = line.split
    # => ["17/6", "shk", "prog", "11:30-14:00", "15:00-18:00"]
begin
    date = elements[0]
    # TODO if date comes with 2-digit year, change to 4-digit
    date << "/" << Date.today.year.to_s if date.length < 6
    proj = elements[1]
    task = (elements[2] if elements[2].to_i == 0) || default_task
    subtask = elements[3] if elements[3].to_i == 0
    periods = elements.drop(2)
    periods = periods.drop_while{|p| p.to_i == 0}
    periods.each do |period|
      must_check = false
      times = period.split('-')
      on = times[0]
      if on.blank?
        on = '23:59' 
        must_check = true
      end
      on += ':00' unless on.include?':'
      start_date = date + ' ' + on
      off = times[1]
      if off.blank?
        off = '23:59' 
        must_check = true
      end
      off += ':00' unless off.include?(':')
      ended_date = date + ' ' + off
      start = Time.zone.parse(start_date)
      ended = Time.zone.parse(ended_date)
      ended += 1.day if start > ended
      duration = ApplicationController.helpers.duration_to_s((ended - start).to_i)
      must_check = must_check || (ended - start) >= 10.hours
      result << self.parse_activity_line(counter, proj, task, subtask, start, ended, duration, must_check)
    end
    return result
  rescue => error
    line = { "line_num": counter, "proj": proj, "task": task, "subtask": subtask, "start": "", "ended": "", "duration": "", "invalid": true }
    line.merge!({ "error": error.inspect })
    result << line
  end
    
  end

  def self.parse_activity_line(counter, proj, task, subtask, start, ended, duration, must_check)
    line = { "line_num": counter, "proj": proj, "task": task, "subtask": subtask, "start": start, "ended": ended, "duration": duration, "must_check": must_check }
    line_objects = self.get_line_objects(line)
    line.merge!({ "invalid": self.line_invalid?(line_objects) })
    line.merge!({ "objects": line_objects })
  end

  def self.get_line_objects(line)
    proj = Project.where("lower(name) = lower('" + line[:proj] + "') or lower(alias) = lower('" + line[:proj] + "')").first
    task = Task.where("lower(name) = lower('" + line[:task] + "') or lower(code) = lower('" + line[:task] + "')").first
    subtask = Subtask.where("lower(name) = ('" + line[:subtask] + "') or lower(code) = lower('" + line[:subtask] + "')").first if line[:subtask]
    subtask ||= nil
    {"proj": proj, "task": task, "subtask": (subtask ? subtask.id : "")}
  end

  def self.line_invalid?(line_objects)
    line_objects[:proj].nil? || line_objects[:task].nil? 
  end

end
