module EshopModule
  module Liquid
    module LiquidTemplate
      
      def render_liquid_template(template, assigns ={}, controller = nil)
        assigns['flash'] = FlashDrop.new(@myflash)
        render :text => render_liquid(template, 'layout', assigns, controller)
      end
      
      #def render_liquid_email_template(template, layout, assigns ={}, controller = nil)
      #  render_liquid_email(template, layout, assigns, controller)
      #end
      
      #def render_partial_liquid_template(template, assigns ={}, controller = nil)
      #  assigns['flash'] = FlashDrop.new(@myflash)
      #  render :text => parse_template("_#{template}", assigns, controller)
      #end
      
      #def render_liquid_template_without_layout(template, assigns ={}, controller = nil)
      #  assigns['flash'] = FlashDrop.new(@myflash)
      #  render :text => parse_template("#{template}", assigns, controller)
      #end
      
      def render_liquid(template, layout, assigns ={}, controller = nil)
        parse_inner_template(template, assigns, controller)        
        #debugger
        render_layout(layout, assigns, controller)
      end
      
      def render_liquid_email(template, layout, assigns ={}, controller = nil)
        parse_inner_email_template(template, assigns, controller)
        render_layout(layout, assigns, controller)
      end 
    
      def render_layout(layout, assigns, controller)
        content = File.read(File.join(@skin_templates, "#{layout}.liquid"))
        #debugger
        #tmpl = ::Liquid::Template.parse(content)
        #returning tmpl.render(assigns, :registers => {:controller => controller}) do |result|
        #  yield tmpl, result if block_given?
        #end        
        my_template = ::Liquid::Template.parse(content)
        #info liquid filters?
        temp = my_template.render( assigns, {:registers => {:controller => controller}, :filters => [LiquidFilters]})
             
        #render :text => temp  
        
        
        #Liquid::Template.parse(content).render 'products' => assigns
        
      end
      
      def parse_template(template, assigns, controller)
        path = File.join(@skin_templates)
        ::Liquid::Template.file_system = ::Liquid::LocalFileSystem.new(path)
        content = File.read(File.join(path, "#{template}.liquid"))
        tmpl = ::Liquid::Template.parse(content)
        returning tmpl.render(assigns, :registers => {:controller => controller}) do |result|
          yield tmpl, result if block_given?
        end
      end
      
      def parse_inner_template(template, assigns, controller)
        parse_template(template, assigns, controller) do |tmpl, result|
          # Liquid::Template takes a copy of the assigns.  
          # merge any new values in to the assigns and pass them to the layout
          tmpl.assigns.each { |k, v| assigns[k] = v } if tmpl.respond_to?(:assigns)
          assigns['content_for_layout'] = result
        end
      end
      
      #def parse_email_template(template, assigns, controller)
      #  path = File.join(@skin_templates, 'email_templates')
      #  ::Liquid::Template.file_system = ::Liquid::LocalFileSystem.new(path)
      #  content = File.read(File.join(path, "#{template}.liquid"))
      #  tmpl = ::Liquid::Template.parse(content)
      #  returning tmpl.render(assigns, :registers => {:controller => controller}) do |result|
      #    yield tmpl, result if block_given?
      #  end
      #end
      
      #def parse_inner_email_template(template, assigns, controller)
      #  parse_email_template(template, assigns, controller) do |tmpl, result|
      #    # Liquid::Template takes a copy of the assigns.  
      #    # merge any new values in to the assigns and pass them to the layout
      #    tmpl.assigns.each { |k, v| assigns[k] = v } if tmpl.respond_to?(:assigns)
      #    assigns['content_for_layout'] = result
      #  end
      #end
      
      private
      
      def simple_formating(text)
        text.gsub(/\r\n?/, "\n").gsub(/\n\n+/, "</p>\n\n<p>").gsub(/([^\n]\n)(?=[^\n])/, '\1<br />')  
      end 
       
    end
  end
end 