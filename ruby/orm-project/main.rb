require 'sqlite3'
require './models'

User.create_table

# p User.objects.all
User.objects.create(full_name: 'Ivaylo Donchev', age: 20)
User.objects.create(full_name: 'Georgi Ivanov', age: 35)
users = User.objects.all
users.map do |user|
  puts 'PK: ' + user.fields['pk'].to_s
  puts 'Full name: ' + user.fields['full_name'].to_s
  puts 'Age: ' + user.fields['age'].to_s
end

User.drop_table
