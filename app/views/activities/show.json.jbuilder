json.extract! @activity, :id, :project, :task, :subtask, :start, :ended, :duration, :chargeable, :charged, :charged_date, :created_at, :updated_at
json.user @activity.user, :id
json.user @activity.user, :name
