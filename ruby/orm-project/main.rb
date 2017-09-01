require 'sqlite3'
require './models'
require './settings'

User.create_table

User.objects.create(full_name: 'Ivaylo Donchev', age: 20)
User.objects.create(full_name: 'Georgi Ivanov', age: 35)

# p User.objects.values

user = User.objects.all[0]
user.fields['full_name'] = 'Pesho'
user.save()


# p User.objects.values
# user.delete()
# p User.objects.values
all_users =  User.objects
ordered = all_users.order_by('pk')
filtered = ordered.filter(pk: 1)
limited = filtered.limit(10)

p all_users.all
ordered.all
filtered.all
limited.all
all_users.values.each { | user |
  p user['full_name']
}
all_users.all.each { | user |
  # p user.class.model_fields['full_name'].to_s
  p user.fields['full_name'].to_s
  user.delete()
}


User.drop_table
