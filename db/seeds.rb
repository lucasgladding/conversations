# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Conversation.delete_all
User.delete_all

user_admin = User.create(username: 'admin', email: 'admin@example.com', password: 'password', password_confirmation: 'password')

Conversation.create(topic: 'Welcome', creator: user_admin)
