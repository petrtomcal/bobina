class Pof
  FILTER_SUFFIX_SEPARATOR = '#'
  SHOW_ALL_PAGE_NO = -1
  FIRST_PAGE_NO = 1
  DEFAULT_ITEMS_PER_PAGE = 10

  attr_accessor :tbl_name, 
                :redir_url, 
                :pof_name, 
                :order_properties, 
                :order_desc, 
                :filter,
                :page_no, 
                :item_count, 
                :items_per_page
  cattr_accessor :default_paging 
  @@default_paging = DEFAULT_ITEMS_PER_PAGE
  
  def initialize(options = {})
    @page_no = options[:page_no].nil? ? FIRST_PAGE_NO : options[:page_no].nil?
    @tbl_name = options[:tbl_name]
    @order_properties = 'id'
    @order_desc = false
    @filter = {}
    @item_count = 0
    @items_per_page = options[:items_per_page].nil? ? @@default_paging : options[:items_per_page]
    @redir_url = options[:redir_url]
    @pof_name = options[:pof_name]
  end
  
  def change_order_properties(order_properties)
    if self.order_properties.eql? order_properties
      self.order_desc = self.order_desc ? false : true
    else
      self.order_properties = order_properties
      self.order_desc = false  
    end 
  end
  
  def add_condition(name, value)
  	self.filter[name] = value
  end
  
  def order
    self.order_properties.split(/,\s*/).collect {|prop|
      prop.insert(0, self.tbl_name + '.') if prop.index('.').nil?
      prop << (self.order_desc ? ' DESC' : '')
    }.join(', ')
  end
  
  def is_empty?
    self.filter.each_value{|v| return false if !v.blank?}
    return true
  end
  
  def filter_params
    res = {}
    self.filter.each_pair{|k,v| res["filter[#{k}]"] = v}
    return res
  end
  
  def conds
    cond = ""
    for f in self.filter
      name, value = f
      if cond.length > 0
        cond += ' AND '
      end
      if name.rindex FILTER_SUFFIX_SEPARATOR
        idx = name.rindex FILTER_SUFFIX_SEPARATOR
        suffix = name[idx + 1 .. -1] 
        name = name[0, idx]
        if name.index('.').nil?
          name = self.tbl_name + '.' + name
        end 
        if suffix == 'min'
          cond += name + " >= ?"
        elsif suffix == 'max'
          cond += name + " <= ?"
        end
      else
        if name.index('.').nil?
          name = self.tbl_name + '.' + name
        end
        cond += name + " LIKE ?"
      end      
    end
    
    if cond.length > 0
      cond = [cond]
      for f in self.filter
        name, value = f
        cond << value.gsub(/\*/, '%').to_sqldatetime
      end    
    else
      cond = nil
    end
    return cond
  end
  
  def offset
    return 0 if show_all?
    first_page! if page_no.to_i < FIRST_PAGE_NO
    result = (page_no.to_i - 1) * items_per_page.to_i
    if result >= item_count
      result = 0
      first_page!
    end
    result
  end
  
  def limit
    return item_count if show_all?
    return items_per_page;
  end
  
  def show_all?
    page_no == SHOW_ALL_PAGE_NO
  end
  
  def show_all!
    self.page_no = SHOW_ALL_PAGE_NO
  end
  
  def first_page?
    page_no == FIRST_PAGE_NO
  end

  def first_page!
    self.page_no = FIRST_PAGE_NO
  end

  def last_page?
    page_no == last_page_no
  end
  
  def previous_page_no
    return page_no if first_page?
    page_no - 1
  end
  
  def next_page_no
    return page_no if show_all? or last_page?
    page_no + 1
  end
  
  def last_page_no
    (item_count.to_f / items_per_page.to_i).ceil
  end

end
