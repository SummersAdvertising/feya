#encoding: UTF-8
class ProductsController < ApplicationController
  before_filter :record_login_redirect_path
  before_filter :count_cartitems

  def index
    @order = Order.new
    @products = Product.where(:status => "上架").all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

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

  def count_cartitems
    if(cookies[:cart])
      @cartitems = JSON.parse(cookies[:cart]) 
      @cartitems_count = @cartitems.length
    else
      @cartitems_count = 0
    end
    
  end
end
