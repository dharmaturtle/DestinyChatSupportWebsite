module ApplicationHelper
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, '#{association}', '#{escape_javascript(fields)}')")
  end

  def get_local_time_zone
    return 'nil' if session[:gmtoffset].nil?
  end

  def admin?
    session[:password] == "secret"
  end

  def time_zone
    tz_off = cookies[:timezone]
   tzinfo = ActiveSupport::TimeZone[tz_off.to_i] unless tz_off.nil?
   return tzinfo
  end
  
  def get_title
  	base_title = "Destiny's Chat"
  	if @title.nil?
  		base_title
  	else
  		"#{base_title} | #{@title}"
  	end
  end
end

