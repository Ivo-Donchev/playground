require './settings'

#
class QuerySet
  # all(), values(), count() and values_list() executes the query and returns list
  def initialize(model, db, where = {}, order_by = [], order_by_desc = false, limit = nil)
    @model = model
    @db = db

    # Query related
    @where = where
    @order_by = order_by # field_names
    @order_by_desc = order_by_desc
    @limit = limit
  end

  def _get_query(select_fields = '*')
    where_clause = ''
    order_by_clause = ''
    limit_clause = ''

    unless @where.empty?
      where_clause = 'WHERE ' + @where.map { | field_name, value|
        "#{field_name} = '#{value}'"
      }.join(' AND ')
    end

    unless @order_by.empty?
      order_by_clause = "ORDER BY #{@order_by.join(', ')}"
      order_by_clause << ' DESC' if @order_by_desc
    end

    limit_clause = "LIMIT #{@limit}" unless @limit.nil?

    "SELECT #{select_fields} FROM #{@model.name} #{where_clause} #{order_by_clause} #{limit_clause}"
  end

  def execute_query(query)
    query += ';'

    puts query if Settings::PRINT_SQL
    @db.execute(query)
  end

  def values_list
    execute_query(self._get_query)
  end

  def values
    values_list.map do |obj_values_list|
      Hash[@model.all_fields.keys.zip(obj_values_list)]
    end
  end

  def all
    # TODO: Fix all's causing global state
    values_list.map { |result| @model.new(*result) }
  end

  def last
    order_by('pk', true).limit(1).all()[0]
  end

  def first
    order_by('pk', false).limit(1).all()[0]
  end

  def order_by(field, desc = false)
    QuerySet.new(@model, @db, @where, @order_by + [field], desc, @limit)
  end

  def filter(filter_by_kwargs)
    new_where = @where.clone
    filter_by_kwargs.each { |field_name, value|
      new_where[field_name] = value
    }
    QuerySet.new(@model, @db, new_where, @order_by, @order_by_desc, @limit)
  end

  def get(get_kwargs)
    self.filter(get_kwargs).limit(1).all()[0]
  end

  def limit(limit_rate)
    QuerySet.new(@model, @db, @where, @order_by, @order_by_desc, limit_rate)
  end

  def count(field='*')
    query = _get_query("COUNT(#{field})")
    execute_query(query)[0][0]
  end

  def _update_obj(obj, fields_dict)
    fields_dict.each { |field_name, val| obj.fields[field_name.to_s].set(val) }
  end

  def create(**args)
    # TODO: Add validations
    related_fields = args.select { |field_name, _| @model.fields[field_name.to_s].class == ForeignKey }

    str_args = args.clone
    args = args.each do |field_name, value|
      if related_fields.keys.include? field_name
        str_args[field_name] = value.fields['pk'].to_s
      end
    end

    obj = @model.new
    _update_obj(obj, args)

    column_names = "(#{str_args.keys.map(&:to_s).join(', ')})"
    values = "(#{str_args.values.map { |value| "\"#{value}\"" }.join(', ')})"

    query = "INSERT INTO #{@model.name} #{column_names} VALUES #{values}"
    execute_query(query)
    self.last
  end
end
