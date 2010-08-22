class CalendarDrop < Liquid::Drop
  
  def initialize(calendar)
    @calendar = calendar
  end
  
  def weekday_names
    @calendar.weekday_names
  end
  
  def previus_month_days
    @calendar.previus_month_days.collect { |day| CalendarDayDrop.new(day) }
  end
  
  def next_month_days
    @calendar.next_month_days.collect { |day| CalendarDayDrop.new(day) }
  end
  
  def days
    @calendar.days.collect { |day| CalendarDayDrop.new(day) }
  end
  
  def month_name
    Date::MONTHNAMES[@calendar.month]
  end
  
  def prev_month
    @calendar.month - 1
  end
  
  def month
    @calendar.month
  end
  
  def next_month
    @calendar.month + 1
  end
  
  def prev_year
    @calendar.year - 1
  end
  
  def year
    @calendar.year
  end
  
  def next_year
    @calendar.year + 1
  end
  
  def code
    @calendar.code
  end
  
  def room_code
    @calendar.code.split('_').first
  end
  
  def plan_code
    @calendar.code.split('_')[1]
  end
  
end
  