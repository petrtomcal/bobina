class CalendarDayDrop < Liquid::Drop
  
  def initialize(calendar_day)
    @calendar_day = calendar_day
  end
  
  def mday
    @calendar_day.mday
  end
  
  def month_name
    Date::MONTHNAMES[@calendar_day.day.month]
  end
  
  def day
    @calendar_day.day.to_s(:eu)
  end
  
  def weekend
    @calendar_day.weekend?
  end
  
  def last_day_of_week
    @calendar_day.last_day_of_week?
  end
  
  def price
    return @calendar_day.options[:rate][:base_price] unless @calendar_day.options[:rate].nil?
    nil
  end
  
  def available
    !self.price.nil?
  end
  
end