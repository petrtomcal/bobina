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
  
end
