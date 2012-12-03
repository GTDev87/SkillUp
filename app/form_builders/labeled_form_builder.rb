class LabeledFormBuilder < ActionView::Helpers::FormBuilder
  
  delegate :content_tag, :tag, to: :@template
  
  [:text_field, :text_area, :password_field, :date_select].each do |method_name|
    define_method(method_name.to_s) do |name, *args|
      content_tag :div, class: "control-group" do
        output_form = field_label(name, *args)
        fields = content_tag :div, class: "controls" do
          super(name, *merge_option_into_args({class: method_name.to_s}, *args)) 
        end
        output_form << fields
      end
    end
  end

  def thumb_image_field(name, *args)
    content_tag :div, class: "control-group" do
      output_form = field_label(name, *args)
      content_tag :div, class: "controls" do
        if object.respond_to?(name)
          output_form << @template.image_tag(object.send(name).url(:thumb))
        end
        output_form << @template.file_field(name, *merge_option_into_args({class: "file_field"}, *args)) 
      end
      output_form
    end
  end
  
  
  def error_messages
    if object.errors.full_messages.any?
      content_tag(:div, :class => "error_messages") do
        content_tag(:h2, "Invalid Fields") +
        content_tag(:ul) do
          object.errors.full_messages.map do |msg|
            content_tag(:li, msg)
          end.join.html_safe
        end
      end
    end
  end
  
  def submit(*args)
    content_tag :div, class: "form-actions" do
      super(*merge_option_into_args({class: "btn btn-primary"}, *args))
    end
  end
  
private
  def merge_option_into_args(new_options, *args)
    options = args.extract_options!
    options.merge!(new_options) {|key, old_opt, new_opt| old_opt.to_s + " " + new_opt.to_s}
    args << options
  end
  
  def field_label(name, *args)
    options = args.extract_options!
    label(name, options[:label], class: "control-label")
  end
  
  #def field_label_tag(name, *args)
  #  options = args.extract_options!
  #  label_tag(name, options[:label], class: "control-label")
  #end
  
  def objectify_options(options)
    super.except(:label)
  end
end