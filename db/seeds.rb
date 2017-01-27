admin = User.new name: "Alfredo", email: "alfredo.roca.mas@gmail.com", admin: true, password: "123123123", password_confirmation: "123123123"
admin.skip_confirmation!
admin.save
