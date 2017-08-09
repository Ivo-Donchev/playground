require 'sqlite3'

require './fields'
require './settings'

# A base class which presents database table
class Model
  # TODO: Add default fields
  class << self
    attr_accessor:fields
  end

  def self.db
    SQLite3::Database.new(Settings::DB_NAME)
  end

  def self.create_table
    query = "CREATE TABLE #{name}"
    column_pairs = @fields.map { |key, value| [key, value.db_column_name] }
    columns = column_pairs.map { |key, value| "#{key} #{value}" }
    query += "( #{columns.join(', ')} );"

    db.execute(query)
  end

  def self.drop_table
    db.execute("DROP TABLE #{name}")
  end

  def self.all
    db.execute("SELECT * FROM #{name};")
  end

  def self.create(**args)
    # TODO: Add validations
    args.each { |field_name, value| fields[field_name.to_s].set(value) }

    column_names = '(' + args.keys.map(&:to_s).join(', ') + ')'
    values = '(' + args.values.map { |value| "\"#{value}\"" }.join(', ') + ')'

    query = "INSERT INTO #{name} #{column_names} VALUES #{values};"
    db.execute(query)
  end
end

class User < Model
  @fields = {
    'full_name' => CharField.new,
    'age' => IntegerField.new
  }
end
