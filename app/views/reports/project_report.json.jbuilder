json.name @project, :name

unless @project.users.empty?

  json.started @project.activities.first.start
  json.last_activity @project.activities.with_end.last.ended

  json.total_duration duration_to_s(@project.activities.with_end.sum(:duration))

  json.tasks @project.tasks do |task|
    json.name task.name
    json.users task.users do |user|
      json.name user.name
      json.activity duration_to_s(user.activities.for_project(@project.id).for_task(task).with_end.sum(:duration))
    end
    json.total_activity duration_to_s(task.activities.for_project(@project.id).with_end.sum(:duration))
  end

  json.users @project.users do |user|
    json.name user.name
    json.tasks user.tasks do |task|
      json.name task.name
      json.activity duration_to_s(task.activities.for_project(@project.id).for_user(user).with_end.sum(:duration))
    end
    json.total_activity duration_to_s(user.activities.for_project(@project.id).with_end.sum(:duration))
  end

else

  

end