module ApplicationHelper
  def link_to_add_field(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    field = f.fields_for(association, new_object, child_index: id) do |builder|
      #NAME OF ASSOCIATION "model_new_fields"
      #should be model/_
      render(association.to_s.pluralize + "/new_field", f: builder)
    end
    link_to(name, '#', class: "add_field", data: {id: id, field: field.gsub("\n", "")})
  end
  
  def labeled_form_for(object, options = {}, &block)
    options[:builder] = LabeledFormBuilder
    options[:html] = { :class => "form-horizontal" }
    form_for(object, options, &block)
  end
  
  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end
end
