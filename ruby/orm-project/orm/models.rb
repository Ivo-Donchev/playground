require 'sqlite3'

require './settings'

require './orm/query'
require './orm/fields'

# A base class which presents database table
class Model
  class << self
    attr_accessor:fields
    attr_accessor:default_fields
  end

  def self.default_fields
    {
      'pk' => AutoField.new
    }
  end

  def self.objects
    QuerySet.new(self, db)
  end

  def self.db
    SQLite3::Database.new(Settings::DB_NAME)
  end

  def self.create_table
    query = "CREATE TABLE #{name}"
    column_pairs = default_fields.merge(@fields).map do |k, v|
      [k, v.db_column_name]
    end

    columns = column_pairs.map { |k, v| "#{k} #{v}" }

    query += "( #{columns.join(', ')} );"

    puts query if Settings::PRINT_SQL
    db.execute(query)
  end

  def self.drop_table
    query = "DROP TABLE #{name}"
    puts query if Settings::PRINT_SQL
    db.execute(query)
  end
end
