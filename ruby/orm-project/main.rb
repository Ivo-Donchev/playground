require 'sqlite3'
require './models'

User.create_table

# p User.objects.all
User.objects.create(full_name: 'Ivaylo Donchev', age: 20)
p User.objects.all

User.drop_table
