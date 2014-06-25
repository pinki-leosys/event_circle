# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all

@host1 =User.create(uname: "host1", email: "host@test.com", password: "host1234", password_confirmation: "host1234" )
 @host1.add_role :host
 @host1.save
 @host =User.create(uname: "guest1", email: "guest@test.com", password: "guest1234", password_confirmation: "guest1234")
 @host.add_role :guest
 @host.save
 @host =User.create(uname: "admin1", email:"admin@test.com", password: "admin1234", password_confirmation: "admin1234")
 @host.add_role :admin
 @host.save


 
