class FlashDrop < Liquid::Drop
  
  def initialize(flash)
    @flash = flash || {}
  end
  
  def message
    if @flash[:error]
      return @flash[:error]
    elsif @flash[:warning]
      return @flash[:warning]
    elsif @flash[:notice]
      return @flash[:notice]
    end
    ''
  end
  
  def notice
    @flash[:notice]
  end
  
  def warning
    @flash[:warning]
  end
  
  def error
    @flash[:error]
  end
  
end