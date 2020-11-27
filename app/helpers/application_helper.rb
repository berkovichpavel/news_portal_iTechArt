module ApplicationHelper
  def form_header(object)
    method = object.new_record? ? 'Create new' : 'Edit'
    "#{method} #{object.class}:"
  end


end
