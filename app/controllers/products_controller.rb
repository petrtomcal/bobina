class ProductsController < ApplicationController
  
  def index
    products = Product.all.collect { |p| ProductDrop.new(p.name) }
    #debugger
    puts ''
    
    #info #going throught lib/liquid_templates.rb 
    #assigns = {:products => products}
    #render_liquid_template 'products/list', assigns, self
    
    #railscast
    #@template = Liquid::Template.parse("hi {{name}}")  # Parses and compiles the template
    #@template.render( 'name' => 'tobi' )               # Renders the output => "hi tobi" 

    #going to standart way
  end
  
  def list
    #puts 'liquid v akci'
    products = Product.all.collect { |p| ProductDrop.new(p.name, p.category_id) }
    assigns = {'products' => products}
    #debugger
    render_liquid_template 'products/list', assigns, self
    
    
#final_render = Liquid::Template.parse(page_layout)  # Parses and compiles the template
#final = final_render.render(assigns)
#
#render :text => final

    #info liquid
    
    #products = Product.all.collect { |p| ProductDrop.new(p.name) }
    #assigns = {:products => products}
    
    #my_template = Liquid::Template.parse("hi {{products.size}}")  # Parses and compiles the template
    #temp = my_template.render( 'products' => products )     
    #render :text => temp
    
    #funkcni hi tobi
    #my_template = Liquid::Template.parse("hi {{name}}")  # Parses and compiles the template
    #temp = my_template.render( 'name' => 'tobi' )     
    #render :text => temp
  end
end
