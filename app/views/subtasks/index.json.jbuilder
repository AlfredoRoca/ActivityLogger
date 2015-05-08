json.array!(@subtasks) do |subtask|
  json.extract! subtask, :id, :name, :code, :task_id
  json.url subtask_url(subtask, format: :json)
end
