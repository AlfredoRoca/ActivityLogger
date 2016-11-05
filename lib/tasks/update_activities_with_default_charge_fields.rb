# 
# code to execute in RAILS CONSOLE to update week and year in existing activities
# 
Activity.all.each{|a| 
  a.update_column(:charged, false)
  a.update_column(:chargeable, true)
}
