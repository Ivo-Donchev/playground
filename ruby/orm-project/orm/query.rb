require './settings'

#
class QuerySet
  def initialize(model, db)
    @model = model
    @db = db
  end

  def execute_query(query)
    query += ';'
    puts query if Settings::PRINT_SQL
    @db.execute(query)
  end

  def values_list
    query = "SELECT * FROM #{@model.name}"
    execute_query(query)
  end

  def values
    self.values_list.map{ |obj_values_list|
      Hash[@model.all_fields.keys.zip(obj_values_list)]
    }
  end

  def all
    #TODO: Fix all's causing global state
    self.values_list.map { |result| @model.new(result) }
  end

  def filter

  end

  def count(field='*')
    query = "SELECT COUNT(#{field}) FROM #{@model.name}"

    execute_query(query)
  end

  def update_obj(obj, fields_dict)
    fields_dict.each { |field_name, val| obj.fields[field_name.to_s].set(val) }
    obj
  end

  def create(**args)
    # TODO: Add validations
    update_obj(@model, args)

    column_names = '(' + args.keys.map(&:to_s).join(', ') + ')'
    values = '(' + args.values.map { |value| "\"#{value}\"" }.join(', ') + ')'

    query = "INSERT INTO #{@model.name} #{column_names} VALUES #{values}"
    execute_query(query)
  end
end
