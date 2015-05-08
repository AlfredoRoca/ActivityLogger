json.array!(@activities) do |activity|
  json.extract! activity, :id, :project, :task, :subtask, :start, :ended, :duration
  json.user activity.user, :id
  json.user activity.user, :name
  json.url activity_url(activity, format: :json)
end
