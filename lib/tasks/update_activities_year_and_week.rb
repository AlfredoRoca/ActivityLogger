# 
# code to execute in RAILS CONSOLE to update week and year in existing activities
# 
Activity.all.each{|a| 
  a.update_column(:week, a.start.strftime("%V"))
  a.update_column(:year, a.start.year)
}
