#
class QuerySet
  def initialize(model, db)
    @model = model
    @db = db
    puts @model
  end

  def all
    @db.execute("SELECT * FROM #{@model.name};")
  end

  def create(**args)
    # TODO: Add validations
    args.each { |field_name, value| @model.fields[field_name.to_s].set(value) }

    column_names = '(' + args.keys.map(&:to_s).join(', ') + ')'
    values = '(' + args.values.map { |value| "\"#{value}\"" }.join(', ') + ')'

    query = "INSERT INTO #{@model.name} #{column_names} VALUES #{values};"
    @db.execute(query)
  end
end
