module MoneyFilters
  
  def format_money(money, symbol, front_position = true)
    if front_position
      symbol + (money.nil? ? '-' : number_to_currency(money,:unit => ''))
    else
      (money.nil? ? '-' : number_to_currency(money,:unit => '')) + symbol
    end
  end
  
  def format_percent(num)
    num = 0 if num.nil?
    number_to_percentage(num, {:precision => 1})
  end

  def number_to_currency(number, options = {})
    options   = options.stringify_keys
    precision = options["precision"] || 2
    unit      = options["unit"] || "$"
    separator = precision > 0 ? options["separator"] || "." : ""
    delimiter = options["delimiter"] || ","
    
    begin
     parts = number_with_precision(number, precision).split('.')
     unit + number_with_delimiter(parts[0], delimiter) + separator + parts[1].to_s
    rescue
     number
    end
  end
  
  def number_to_human_size(size, precision=1)
    size = Kernel.Float(size)
    case 
      when size == 1        : "1 Byte"
      when size < 1.kilobyte: "%d Bytes" % size
      when size < 1.megabyte: "%.#{precision}f KB"  % (size / 1.0.kilobyte)
      when size < 1.gigabyte: "%.#{precision}f MB"  % (size / 1.0.megabyte)
      when size < 1.terabyte: "%.#{precision}f GB"  % (size / 1.0.gigabyte)
      else                    "%.#{precision}f TB"  % (size / 1.0.terabyte)
    end.sub('.0', '')
    rescue
    nil
  end
  
  def number_to_percentage(number, options = {})
    options   = options.stringify_keys
    precision = options["precision"] || 3
    separator = options["separator"] || "."
    
    begin
     number = number_with_precision(number, precision)
     parts = number.split('.')
     if parts.at(1).nil?
       parts[0] + "%"
     else
       parts[0] + separator + parts[1].to_s + "%"
     end
    rescue
     number
    end
  end
  
  def number_with_delimiter(number, delimiter=",", separator=".")
    begin
     parts = number.to_s.split('.')
     parts[0].gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{delimiter}")
     parts.join separator
    rescue
     number
    end
  end
  
  def number_with_precision(number, precision=3)
    "%01.#{precision}f" % number
    rescue
      number
  end
  
end