module ErrorsFilters

  def error_messages_on(object, method_name)
    return '' if object.nil?
    return '' if object.errors.nil?
    if (errors = object.errors.on(method_name))
      errors.is_a?(Array) ? errors.first.to_s : errors.to_s
    else
      ''
    end
  end
  
  def set_style_for_error(object, method_name, style)
    return '' if object.nil?
    return '.nil' if object.errors.nil?
    if (errors = object.errors.on(method_name))
      return style
    else
      return ''
    end
  end
  
end