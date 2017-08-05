# 'fetch_deep' accepts dot_path 'path.to.value.in.dict' and return value
# 'reshape' accepts shape in the format {'key': <dot_path>} and returns the shaped dict

class Array
	def reshape(shape)
		map { |value| value.reshape(shape) }
	end
  def fetch_deep(dot_path)
    key, dot_path = dot_path.split('.', 2)
    value = self[key.to_i]

    return value if not dot_path or not value
    value.fetch_deep(dot_path)
  end
end


class Hash
  def fetch_deep(dot_path)
    key, dot_path = dot_path.split('.', 2)
    value = self[key.to_s] || self[key.to_sym]

    return value if not dot_path or not value
    value.fetch_deep(dot_path)
  end
  def reshape(shape)
		return fetch_deep(shape) if shape.is_a? String

    shape.map do |new_key, new_shape|
      [new_key, reshape(new_shape)]
    end.to_h
  end
end
