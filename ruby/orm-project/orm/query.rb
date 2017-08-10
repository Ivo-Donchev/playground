require './settings'

#
class QuerySet
  def initialize(model, db)
    @model = model
    @db = db
  end

  def all
    query = "SELECT * FROM #{@model.name};"
    puts query if Settings::PRINT_SQL
    @db.execute(query)
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

    query = "INSERT INTO #{@model.name} #{column_names} VALUES #{values};"
    puts query if Settings::PRINT_SQL
    @db.execute(query)
  end
end
