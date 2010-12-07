class ProductsController < ApplicationController
  
  def index
    list
  end
  
  def list
    #puts 'liquid v akci'
    products = Product.all.collect { |p| ProductDrop.new(p.name, p.category_id, p.price, p.attachments, p.id) }
    assigns = {'products' => products}
    #debugger
    render_liquid_template 'products/list', assigns, self
    #info liquid
    #funkcni hi tobi
    #my_template = Liquid::Template.parse("hi {{name}}")  # Parses and compiles the template
    #temp = my_template.render( 'name' => 'tobi' )     
    #render :text => temp
  end
end
