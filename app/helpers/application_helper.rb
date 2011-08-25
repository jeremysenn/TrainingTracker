module ApplicationHelper

  def link_to_add_exercise_session_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    new_object.weight_sets.build
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
    #fields = fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      #safe_concat(render(association.to_s.singularize + "_fields", :f => builder))
      render("exercise_sessions/form.html.haml", :form => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

  def link_to_add_weight_set_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
    #fields = fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      #safe_concat(render(association.to_s.singularize + "_fields", :f => builder))
      render("weight_sets/form.html.haml", :form => builder)
    end
    link_to_function(name, "add_weight_set_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

  def link_to_remove_exercise_session_fields(name, f)
    f.hidden_field(:_destroy, :value => 0) + link_to_function(name, "remove_exercise_fields(this)")
  end

  def link_to_remove_weight_set_fields(name, f)
    f.hidden_field(:_destroy, :value => 0) + link_to_function(name, "remove_weight_set_fields(this)")
  end

  def link_to_remove_video_fields(name, f)
    f.hidden_field(:_destroy, :value => 0) + link_to_function(name, "remove_video_fields(this)")
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy, :value => 0) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_video_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render("videos/video_form.html.haml", :form => builder)
    end
    link_to_function(name, "add_video_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

  def sanitized_object_name(object_name)
    object_name.gsub(/\]\[|[^-a-zA-Z0-9:.]/,"_").sub(/_$/,"")
  end

  def sanitized_method_name(method_name)
    method_name.sub(/\?$/, "")
  end

  def form_tag_id(object_name, method_name)
    "#{sanitized_object_name(object_name.to_s)}_#{sanitized_method_name(method_name.to_s)}"
  end

  def video_thumbnail(video, width = 240)
    if !video.url.blank?
      video_info = VideoInfo.new(video.url)
      image_tag(video_info.thumbnail_small, :width => 240, :rel => "#video_#{video.id}")
    else
      video.embed_code
    end
  end

end
