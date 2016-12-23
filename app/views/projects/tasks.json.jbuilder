json.array!(@tasks) do |task|
  json.extract! task, :id, :name, :code
end
