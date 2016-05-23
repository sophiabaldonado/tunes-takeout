module ApplicationHelper
  def current_page
    request.env['PATH_INFO']
  end
end
