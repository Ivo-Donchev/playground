require 'sqlite3'
require './models'


my_model = User.new

User.create_table
p User.all
User.create({:full_name => "Ivaylo Donchev", :age => 20})
p User.all
User.drop_table
# puts User.fields

