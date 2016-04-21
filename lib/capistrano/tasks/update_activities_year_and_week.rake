desc "Update year and week for existing activities"
task :update_year_and_week_of_activities do
    # execute "cd #{current_path}"
      within current_path do
        execute :rake, "update_year_and_week_of_activities"
      end
end