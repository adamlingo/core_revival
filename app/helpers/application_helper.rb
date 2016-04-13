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
end 
