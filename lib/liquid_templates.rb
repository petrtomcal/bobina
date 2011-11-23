module EshopModule
  module Liquid
    module LiquidTemplate
      
      def render_liquid_template(template, assigns ={}, controller = nil)
        assigns['flash'] = FlashDrop.new(@myflash)
        render :text => render_liquid(template, 'layout', assigns, controller)
      end
      
            
      def render_liquid(template, layout, assigns ={}, controller = nil)
        parse_inner_template(template, assigns, controller)        
        render_layout(layout, assigns, controller)
      end
      
     def render_layout(layout, assigns, controller)
        content = File.read(File.join(@skin_templates, "#{layout}.liquid"))
        my_template = ::Liquid::Template.parse(content)
        temp = my_template.render( assigns, :registers => {:controller => controller})        
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
          tmpl.assigns.each { |k, v| assigns[k] = v } if tmpl.respond_to?(:assigns)
          assigns['content_for_layout'] = result
        end
      end    
      
      private
      
      def simple_formating(text)
        text.gsub(/\r\n?/, "\n").gsub(/\n\n+/, "</p>\n\n<p>").gsub(/([^\n]\n)(?=[^\n])/, '\1<br />')  
      end 
       
    end
  end
end 