module ApplicationHelper

  # Return full title on each page
  def full_title(page_title = '')
    base_title = "Core Employee Solutions"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end 
