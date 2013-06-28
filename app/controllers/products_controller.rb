#encoding: UTF-8
class ProductsController < ApplicationController
  before_filter :record_login_redirect_path
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
    
    if(@product)
      @product["hasType"] = (@product.stocks.first.typename != "default")
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end
end
