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
    related_fields = @fields.select { |field_name, value| value.class == ForeignKey }

    if not keys.empty?
      @fields.keys.each_with_index { |field_name, index|
        if not related_fields.include? field_name
          @fields[field_name].set(keys[index].to_s)
        else
          @fields[field_name].set(@fields[field_name.to_s].to_model.objects.get(pk: keys[index]))
        end
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
    references_str = ''

    columns = all_fields.map { |k, v|
      [k, v.db_column_name]
    }.map { |k, v| "#{k} #{v}" }

    fk_fields = all_fields.select{ |_, value|
      value.class == ForeignKey
    }
    references_str_arr = fk_fields.map { |field_name, value|
       "FOREIGN KEY (#{field_name}) REFERENCES #{value.to_model}(pk)"
    }
    references_str =  ', ' + references_str_arr.join(', ') if not references_str_arr.empty?

    query += "( #{columns.join(', ')} #{references_str})"

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
