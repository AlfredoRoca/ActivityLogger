json.user @user.name
unless @user.activities.empty?
  json.first_activity @user.activities.with_end.first.start
  json.last_activity @user.activities.with_end.last.ended
  json.tasks @user.tasks do |task|
    json.name task.name
    json.activity duration_to_s(task.activities.for_user(@user).with_end.sum(:duration))
  end
  json.total_activity duration_to_s(@user.activities.sum(:duration))

  json.projects @user.projects do |project|
    json.name project.name
    json.tasks project.tasks do |task|
      json.name
      json.activity duration_to_s(task.activities.for_user(@user).for_project(project).with_end.sum(:duration))
    end
    json.total_activity duration_to_s(project.activities.for_user(@user).with_end.sum(:duration))
  end
end