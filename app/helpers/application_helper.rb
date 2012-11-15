module ApplicationHelper
  def resource_name
    :user
  end

  def resource
     @devise_resource ||= User.new
  end

  def devise_mapping
     @devise_mapping ||= Devise.mappings[:user]
  end
  
  def currentPath(path)
    "here" if current_page?(path)
  end
end

