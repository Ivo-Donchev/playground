# 'fetch_deep' accepts dot_path 'path.to.value.in.dict' and return value
# 'reshape' accepts shape in the format {'key': <dot_path>} and returns the shaped dict

class Hash
  def fetch_deep(dot_path)
    dot_path.split('.').reduce(self) { |some_dict, key| some_dict[key.to_s] if some_dict.class == Hash }
  end
  def reshape(shape)
    shape.each { |key, value| shape[key] = self.fetch_deep(value) }
  end
end
