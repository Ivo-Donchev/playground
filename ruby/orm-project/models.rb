require './orm/models'
require './orm/fields'

#
class Profile < Model
  @fields = {
    'avatar' => FileField.new
  }
end

#
class User < Model
  @fields = {
    'full_name' => CharField.new,
    'age' => IntegerField.new,
    'profile' => ForeignKey.new(Profile)
  }
end
