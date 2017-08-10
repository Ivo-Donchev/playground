class Field
  attr_accessor:db_column_name

  def initialize
    @alive = false
  end

  def set(value)
    @value = value
    @alive = true
  end

  def to_s
    @value
  end
end

class CharField < Field
  def initialize
    @db_column_name = 'varchar(255)'
  end
end

class IntegerField < Field
  def initialize
    @db_column_name = 'int'
  end
end
