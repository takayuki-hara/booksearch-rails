module ApplicationHelper
  def page_category
    return @page_category
  end

  def bg_color
    if page_category == 'manage'
      return 'bg-danger'
    else
      return 'bg-info'
    end
  end

end
