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

#
class CharField < Field
  def initialize
    super
    @db_column_name = 'varchar(255)'
  end
end

#
class FileField < CharField
end

#
class IntegerField < Field
  def initialize
    super
    @db_column_name = 'int'
  end
end

#
class AutoField < Field
  def initialize(primary_key = true)
    super()
    @db_column_name = 'INTEGER PRIMARY KEY AUTOINCREMENT'
    @primary_key = primary_key
  end

  def to_s
    @value.to_s
  end
end

#
class ForeignKey < Field
  attr_accessor:to_model

  def initialize(model)
    super()
    @db_column_name = 'INTEGER NOT NULL'
    @to_model = model
  end

  def to_s
    @to_model.objects.get(pk: @value.fields['pk'])
  end
end
