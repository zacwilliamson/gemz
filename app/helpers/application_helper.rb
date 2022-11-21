module ApplicationHelper
  def main_layout(controller, action)
    return 'md:ml-[243px] w-full' unless ['sessions#new',
                                          'registrations#new'].include?("#{controller}##{action}")
  end
end
