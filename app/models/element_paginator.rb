class ElementPaginator
  #entire class needs tests
  def initialize(object, offset_id)
    @object = object
    @element_offset = (offset_id.nil? && 0) || @object.entries.index{ |entry| entry.id.to_s == offset_id } 
    @elements_per_page = 5
    @next_id_parameter = :next_id
  end

  def total_elements
    @object.size
  end

  def elements_per_page=(num_elements)
    @elements_per_page = num_elements
  end

  def next_id_parameter=(param)
    @next_id_parameter = param
  end

  def next_id_parameter
    @next_id_parameter
  end

  def offset_element(offset)
    @element_offset += offset
  end

  def next_page_offset_id
    @object[@element_offset + @elements_per_page].id
  end

  def last_page?
    !(@element_offset + @elements_per_page < total_elements)
  end

  def current_elements
    @object[@element_offset..@element_offset + @elements_per_page - 1]
  end
end