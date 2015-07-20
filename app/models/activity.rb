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

  ACTIVITY_IMPORT_FILE = "tmp/tareas.txt"

  def calc_duration
    # binding.pry
  	if self.ended && self.start
      self.duration = self.ended - self.start
    else
      0
  	end
  end


  # PARSE TEXT FILE WITH ACTIVITY LINES
  # 
  def self.read_activity_file
    if File.exists?(ACTIVITY_IMPORT_FILE)
      parsed_lines = []
      counter = 0
      File.open(ACTIVITY_IMPORT_FILE, "r+") do |f|
        f.each_line do |line| 
          counter += 1
          parsed_lines << self.parse_file_line(line, counter) unless line.start_with?"#","\n"
        end
      end
      parsed_lines
    else
      return ACTIVITY_IMPORT_FILE + " not found"
    end
  end

  private

  def self.parse_file_line(line, counter)
    # TODO extract subtasks and add to subtasks table if new
    # # sintaxis
    # # DD/MM[YY default current] PROJ [TASK default prog [SUBTASK]] HH:MM-HH:MM [HH:MM-HH:MM] [HH:MM-HH:MM] ...
    # ## PROJ name or alias, case insensitive
    # ## HH:MM-HH:MM start-end

    # Example
    # 16/6 shk prog 20:00-5:00
    # 17/6 shk prog 11:30-14:00 15:00-18:00

    default_task = "prog"

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
      times = period.split('-')
      on = times[0]
      on += ':00' unless on.include?':'
      start_date = date + ' ' + on
      off = times[1]
      off += ':00' unless off.include?(':')
      ended_date = date + ' ' + off
      start = DateTime.strptime(start_date + ' ' + on, "%d/%m/%Y %H:%M")
      ended = DateTime.strptime(ended_date + ' ' + off, "%d/%m/%Y %H:%M")
      ended += 1 if start > ended
      duration = ApplicationController.helpers.duration_to_s(((ended - start)*24*60*60).to_i)
      return self.parse_activity_line(counter, proj, task, subtask, start, ended, duration)
    end
  rescue => error
    line = { "line_num": counter, "proj": proj, "task": task, "subtask": subtask, "start": "", "ended": "", "duration": "", "invalid": true }
    line.merge!({ "error": error.inspect })
  end
    
  end

  def self.parse_activity_line(counter, proj, task, subtask, start, ended, duration)
    line = { "line_num": counter, "proj": proj, "task": task, "subtask": subtask, "start": start, "ended": ended, "duration": duration }
    line_objects = self.get_line_objects(line)
    line.merge!({ "invalid": self.line_invalid?(line_objects) })
    line.merge!({ "objects": line_objects })
  end

  def self.get_line_objects(line)
    proj = Project.where("name = '" + line[:proj] + "' or alias = '" + line[:proj] + "'").first
    task = Task.where("name = '" + line[:task] + "' or code = '" + line[:task] + "'").first
    subtask = Subtask.where("name = '" + line[:subtask] + "' or code = '" + line[:subtask] + "'").first if line[:subtask]
    subtask ||= nil
    {"proj": proj, "task": task, "subtask": (subtask ? subtask.id : "")}
  end

  def self.line_invalid?(line_objects)
    line_objects[:proj].nil? || line_objects[:task].nil? 
  end

end
