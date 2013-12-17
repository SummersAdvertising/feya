#encoding: UTF-8
class ProductsController < ApplicationController
  before_filter :record_login_redirect_path
  before_filter :count_cartitems
  before_filter :get_category

  def show
    @order = Order.new
    @product = Product.where(:status => "上架", :id => params[:id]).first
    @cartitem = Orderitem.new
    
    if(@product)
      @product["hasType"] = (@product.stocks.first.typename != "default")
      @product["hasStock"] = hasStocks?(@product)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  def hasStocks?(product)
    @product = product
    @product.stocks.each do |stock|
      if stock.amount
        if stock.amount > 0
          return true
        else
          next
        end
      else
        return true
      end
    end

    return false    
  end
    
private
	def get_category
		@categories = Category.order( :lft => :asc )
		@category = Category.find( params[ :category_id ] )
	end  
end
