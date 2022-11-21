module ApplicationHelper
  def main_layout(controller, action)
    return 'md:pl-[243px]' unless ['sessions#new',
                                   'registrations#new'].include?("#{controller}##{action}")
  end

  def right_content(controller, action)
    return 'px-5 my-4' unless ['sessions#new',
                          'registrations#new'].include?("#{controller}##{action}")
  end
end
