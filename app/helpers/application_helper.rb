module ApplicationHelper
  def css_class_for_flash(name)
    case name
    when :alert
      'alert-error'
    when :notice
      'alert-success'
    else
      "alert-info"
    end
  end
end
