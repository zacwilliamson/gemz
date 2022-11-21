module ApplicationHelper
  def grid_layout(controller, action)
    if ['sessions#new', 'registrations#new'].include?("#{controller}##{action}")
      'poppins bg-lm-1 text-dm-1 dark:bg-dm-1 dark:text-lm-1 h-screen'
    else
      'poppins bg-lm-1 text-dm-1 dark:bg-dm-1 dark:text-lm-1 h-screen md:grid md:grid-cols-nav'
    end
  end

  def margin(controller, action)
    return 'md:ml-[243px]' unless ['sessions#new', 'registrations#new'].include?("#{controller}##{action}")
  end
end
