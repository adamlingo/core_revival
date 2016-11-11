module ApplicationHelper
  # This module is to create linear browser titles
  # if pages uses <% provide(:title, 'Page Title') %>
  #     Example: "Home | Core Solutions"
  # Return full title on each page
  def full_title(page_title = '')
    base_title = "Core Solutions"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  # this can be used for field entry directions to users in views
  def field_errors(object, column)
    errors = object.errors[column]
    if errors.present?
      content_tag(:p, errors.to_sentence, class: "field-error")
    end
  end
end 
