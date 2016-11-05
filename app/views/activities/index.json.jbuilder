json.array!(@activities) do |activity|
  json.extract! activity, :id, :project_id, :task_id, :subtask_id, :start, :ended, :description
  json.project_name activity.project.try(:name)
  json.task_name activity.task.try(:name)
  json.subtask_name activity.subtask.try(:name)
  json.user_id activity.user.id
  json.user_name activity.user.name
  json.duration duration_to_s(activity.duration)
  json.chargeable activity.chargeable
  json.charged activity.charged
  json.charged_date activity.charged_date
  json.url activity_url(activity, format: :json)
  json.showUrl activity_path(activity) 
  json.editUrl edit_activity_path(activity) 
  json.destroyUrl activity_path(activity) 
end
