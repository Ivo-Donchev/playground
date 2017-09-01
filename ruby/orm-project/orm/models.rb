require 'sqlite3'

require './settings'

require './orm/query'
require './orm/fields'

# A base class which presents database table
class Model
  attr_accessor:fields
  class << self
    attr_accessor:fields
  end

  def initialize(*keys)
    @fields = self.class.default_fields.merge(self.class.fields)

    # TODO: Fix this
    if not keys.empty?
      @fields.keys.each_with_index { |field_name, index|
        @fields[field_name].set(keys[index].to_s)
      }
    end
  end

  def self.default_fields
    { 'pk' => AutoField.new }
  end

  def self.all_fields
      default_fields.merge(@fields)
  end

  def self.objects
    QuerySet.new(self, db)
  end

  def self.db
    SQLite3::Database.new(Settings::DB_NAME)
  end

  def self.create_table
    query = "CREATE TABLE #{name}"
    columns = all_fields.map { |k, v|
      [k, v.db_column_name]
    }.map { |k, v| "#{k} #{v}" }

    query += "( #{columns.join(', ')} );"

    puts query if Settings::PRINT_SQL
    db.execute(query)
  end

  def self.drop_table
    query = "DROP TABLE #{name};"

    puts query if Settings::PRINT_SQL
    db.execute(query)
  end

  def save
    updated_fields_pairs = @fields.select { |field_name, _|
      not self.class.default_fields.include? field_name
    }.map { |field_name, new_value|
      "#{field_name} = '#{new_value}'"
    }.join(', ')

    query = "UPDATE #{self.class.name} SET #{updated_fields_pairs} WHERE pk = #{fields['pk']}"

    puts query if Settings::PRINT_SQL
    self.class.db.execute(query)
  end

  def delete
    query = "DELETE FROM #{self.class.name} WHERE pk = #{fields['pk']}"

    puts query if Settings::PRINT_SQL
    self.class.db.execute(query)
  end
end
