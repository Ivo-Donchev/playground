require './orm/models'
require './orm/fields'

#
class User < Model
  @fields = {
    'full_name' => CharField.new,
    'age' => IntegerField.new
  }
end
