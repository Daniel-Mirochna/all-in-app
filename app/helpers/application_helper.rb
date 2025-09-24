module ApplicationHelper
  def active_nav_link(path)
    "dark:text-purple-400" if request.path == path
  end
end
