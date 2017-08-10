require 'sqlite3'

require './orm/query'
require './settings'

# A base class which presents database table
class Model
  def self.objects
    QuerySet.new(self, db)
  end
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
end

