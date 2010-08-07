module PofHelper
  def pof_order_header(pof, options = {}) #order_by, label, 
    options[:label] = options[:order_by].gsub(/_id$/, '').humanize if options[:label].blank?
    if pof.order_properties == options[:order_by]
      if pof.order_desc
        class_value = 'pof-order-desc'
      else
        class_value = 'pof-order-asc'
      end
    end
    if class_value.nil?
      result = link_to(options[:label], { :action => 'change_pof', :order => options[:order_by], :pof_name => pof.pof_name } )
    else
      result = link_to(options[:label], { :action => 'change_pof', :order => options[:order_by], :pof_name => pof.pof_name }, { :class => class_value } )
    end
    return result
  end
  
  def pof_navigation(pof)
    result = ''
    
    if pof.last_page_no > Pof::FIRST_PAGE_NO
      if not pof.first_page?
        result << link_to('1', :action=>'change_pof', :pof_name => pof.pof_name, :page_no=>Pof::FIRST_PAGE_NO) << " &nbsp;"
      else
        result << "<b>1 &nbsp;</b>"
      end
      
      for page_number in get_pages_numbers(pof)
        items_count_link = page_number.to_i * pof.items_per_page.to_i - pof.items_per_page.to_i + 1
        if page_number.to_i != pof.page_no.to_i
          result << link_to(items_count_link, :action=>'change_pof', :pof_name => pof.pof_name, :page_no => page_number ) << " &nbsp;"
        else
          result << "<b>#{items_count_link} &nbsp;</b>"
        end  
      end

      items_count_link = pof.last_page_no.to_i * pof.items_per_page.to_i - pof.items_per_page.to_i + 1
      if not pof.last_page?
        result << link_to(items_count_link, :action=>'change_pof', :pof_name => pof.pof_name, :page_no => pof.last_page_no) << " &nbsp;"
      else
        result << "<b>#{items_count_link} &nbsp;</b>"
      end

      if pof.show_all?
        result << "<b>vše</b>"
      else
        if pof.item_count > 500
          result << link_to('vše', {:action=>'change_pof', :pof_name => pof.pof_name, :page_no=>Pof::SHOW_ALL_PAGE_NO}, :confirm => 'Záznamů je hodně. Opravdu vypsat všechny?')
        else
          result << link_to('vše', :action=>'change_pof', :pof_name => pof.pof_name, :page_no=>Pof::SHOW_ALL_PAGE_NO)
        end
      end
    else
      result << '<br />'
        result << _('find') << ' ' << pof.item_count.to_s << ' ' << _('items')
    end
    
    result << '<table style="width: auto;"><tr>'
    result << '<td>' << _('Items on page') << '</td>'
    result << '<td>' << start_form_tag(:action => 'change_pof', :pof_name => pof.pof_name) 
    result << text_field_tag("items_per_page", pof.items_per_page, :size => 2, :style => 'text-align : right')
    result << image_submit_tag('/images/icons/silk/accept.png', {:name => 'set_filter', :class => 'submit', :style => 'width: 1.3em;'})
    result << end_form_tag << '</td>'
    result << '</tr></table>'
    
    return result
  end
  
  def get_pages_numbers(pof)
    count_in_grade = 14
    count_in_grade = 6 if pof.last_page_no > 15
    count_in_grade = 5 if pof.last_page_no > 100
    count_in_grade = 4 if pof.last_page_no > 1000
    count_in_grade = 3 if pof.last_page_no > 10000

    page_no = pof.page_no
    page_no = 1 if page_no < 0
    pages_numbers = []
    
    i = page_no - 1
    grade = 1
    
    while i > 1
      while (i % grade != 0)
        i -= 1
      end

      limit = grade * 10
      limit = pof.last_page_no if limit > 10 * pof.last_page_no
      offset = limit / count_in_grade
      offset = offset / grade * grade 

      count_in_grade.times {
        break if i <= 1
        pages_numbers += [i.to_s]
        if grade == 1 
          i -= 1
        else 
          i -= offset
        end
      }
      grade *= 10
    end
    pages_numbers.reverse!

    pages_numbers += [page_no] if page_no > 1 && page_no < pof.last_page_no
    
    i = page_no + 1
    grade = 1

    while (i < pof.last_page_no)
      while (i % grade != 0)
        i += 1
      end

      limit = grade * 10
      limit = pof.last_page_no if limit > 10 * pof.last_page_no
      offset = limit / count_in_grade
      offset = offset / grade * grade 

      count_in_grade.times {
        break if i >= pof.last_page_no.to_i
        pages_numbers += [i.to_s]
        if grade == 1 
          i += 1
        else 
          i += offset
        end
      }
      grade *= 10
    end
    return pages_numbers
  end

  def filter_date_field(pof, property_name)
    tmp = ""
    tmp << text_field_tag("filter[#{property_name}#min]", pof.filter["#{property_name}#min"], :class => "datefield") 
    tmp << image_tag('/images/icons/silk/calendar.gif', { :id => property_name + "_min_filter_calendar", :style => 'cursor: pointer; padding-left: .5em; vertical-align: middle;', :title => 'Výběr data', :onmouseover => "this.style.background='red';", :onmouseout => "this.style.background=''" })
    tmp << "<script type=\"text/javascript\">Calendar.setup({inputField :\"" << "filter[#{property_name}#min]" << "\", ifFormat:\"%d.%m.%Y\", button:\"" << property_name << "_min_filter_calendar\"});</script>"
    tmp << "<br/>"
    tmp << text_field_tag("filter[#{property_name}#max]", pof.filter["#{property_name}#max"], :class => "datefield") 
    tmp << image_tag('/images/icons/silk/calendar.gif', { :id => property_name + "_max_filter_calendar", :style => 'cursor: pointer; padding-left: .5em; line-height: 1.2em; vertical-align: middle;', :title => 'Výběr data', :onmouseover => "this.style.background='red';", :onmouseout => "this.style.background=''" }) 
    tmp << "<script type=\"text/javascript\">Calendar.setup({inputField :\"" << "filter[#{property_name}#max]" << "\", ifFormat:\"%d.%m.%Y\", button:\"" << property_name << "_max_filter_calendar\"});</script>"
    return tmp
  end
  
  def filter_datetime_field(pof, property_name)
    tmp = ""
    tmp << text_field_tag("filter[#{property_name}#min]", pof.filter["#{property_name}#min"], :class => "datetimefield") 
    tmp << image_tag('/images/icons/silk/calendar.gif', { :id => property_name + "_min_filter_calendar", :style => 'cursor: pointer; padding-left: .5em; vertical-align: middle;', :title => 'Výběr data', :onmouseover => "this.style.background='red';", :onmouseout => "this.style.background=''" })
    tmp << "<script type=\"text/javascript\">Calendar.setup({inputField :\"" << "filter[#{property_name}#min]" << "\", ifFormat:\"%d.%m.%Y %H:%M\", button:\"" << property_name << "_min_filter_calendar\",showsTime:\"true\"});</script>"
    tmp << "<br/>"
    tmp << text_field_tag("filter[#{property_name}#max]", pof.filter["#{property_name}#max"], :class => "datetimefield") 
    tmp << image_tag('/images/icons/silk/calendar.gif', { :id => property_name + "_max_filter_calendar", :style => 'cursor: pointer; padding-left: .5em; line-height: 1.2em; vertical-align: middle;', :title => 'Výběr data', :onmouseover => "this.style.background='red';", :onmouseout => "this.style.background=''" })
    tmp << "<script type=\"text/javascript\">Calendar.setup({inputField :\"" << "filter[#{property_name}#min]" << "\", ifFormat:\"%d.%m.%Y %H:%M\", button:\"" << property_name << "_max_filter_calendar\",showsTime:\"true\"});</script>"
    return tmp
  end
  
  def filter_min_max(pof, property_name)
    tmp = ""
    tmp << '<label for="min">Min:</label>' + text_field_tag("filter[#{property_name}#min]", pof.filter["#{property_name}#min"], { :style => 'width: 4em;'}) 
    tmp << '<br/><label for="max">Max:</label>' + text_field_tag("filter[#{property_name}#max]", pof.filter["#{property_name}#max"], { :style => 'width: 4em;'}) 
    return tmp
  end
  
  def fast_filter(pof, name, conditions)
    tmp = ""
    tmp << link_to(name, pof.filter_params.merge({:action => 'change_pof', :pof_name => pof.pof_name}.merge(conditions)), :method => :post)
    return tmp
  end
  
  def fast_filter_date(pof, name, attr_name, minval, maxval)
    tmp = ""
    tmp << link_to(name, pof.filter_params.merge({:action => 'change_pof', :pof_name => pof.pof_name, 
                                     "filter[#{attr_name}#min]" => hdate(minval),
                                     "filter[#{attr_name}#max]" => hdate(maxval)}), :method => :post)
    return tmp
  end
  
  def fast_filter_text(pof, name, attr_name, val)
    tmp = ""
    tmp << link_to(name, pof.filter_params.merge({:action => 'change_pof', :pof_name => pof.pof_name, "filter[#{attr_name}]" => val}), :method => :post)
    return tmp
  end
  
end
