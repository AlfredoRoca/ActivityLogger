desc "Update year and week for existing activities"
task :update_year_and_week_of_activities do
  puts "Esto puede tardar un poco, ten paciencia..."
  Activity.all.each{|a| 
    a.update_column(:week, a.start.strftime("%V"))
    a.update_column(:year, a.start.year)
  }
end