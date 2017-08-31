require 'sqlite3'
require './models'
require './settings'

User.create_table

User.objects.create(full_name: 'Ivaylo Donchev', age: 20)
User.objects.create(full_name: 'Georgi Ivanov', age: 35)

puts "--------------------------------------"
puts "--------------------------------------"
puts "--------------------------------------"

p User.objects.values

user = User.objects.all[0]
user.fields['full_name'] = 'Pesho'
user.save()

puts "--------------------------------------"
puts "--------------------------------------"
puts "--------------------------------------"

p User.objects.values
user.delete()
p User.objects.values

User.drop_table
