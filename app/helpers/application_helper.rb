module ApplicationHelper
  def main_layout(controller, action)
    return 'pt-[90px] md:pt-[0px] md:pl-[243px]' unless ['sessions#new',
                                                          'registrations#new'].include?("#{controller}##{action}")
  end

  def right_content(controller, action)
    return 'px-5 my-0 md:my-4' unless ['sessions#new',
                                       'registrations#new'].include?("#{controller}##{action}")
  end

  def bg_colors
    { red: 'bg-[#ff5769]',
      orange: 'bg-[#ff774e]',
      yellow: 'bg-[#ffae40]',
      green: 'bg-[#68be61]',
      cyan: 'bg-[#30cdbf]',
      lightblue: 'bg-[#6cb0f3]',
      darkblue: 'bg-[#5082e7]',
      purple: 'bg-[#7670cc]',
      pink: 'bg-[#f57aae]' }
  end

  def border_colors
    { red: 'border-[#ff5769]',
      orange: 'border-[#ff774e]',
      yellow: 'border-[#ffae40]',
      green: 'border-[#68be61]',
      cyan: 'border-[#30cdbf]',
      lightblue: 'border-[#6cb0f3]',
      darkblue: 'border-[#5082e7]',
      purple: 'border-[#7670cc]',
      pink: 'border-[#f57aae]' }
  end

  def text_colors
    { red: 'text-[#ff5769]',
      orange: 'text-[#ff774e]',
      yellow: 'text-[#ffae40]',
      green: 'text-[#68be61]',
      cyan: 'text-[#30cdbf]',
      lightblue: 'text-[#6cb0f3]',
      darkblue: 'text-[#5082e7]',
      purple: 'text-[#7670cc]',
      pink: 'text-[#f57aae]' }
  end
end
