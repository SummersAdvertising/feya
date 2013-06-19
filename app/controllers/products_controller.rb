class ProductsController < ApplicationController
  before_filter :record_login_redirect_path
  def index
    @order = Order.new
    @products = Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  def show
    @order = Order.new
    @product = Product.find(params[:id])
    @product["hasType"] = (@product.stocks.first.typename != "default")

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end
end
