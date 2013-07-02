#encoding: UTF-8
class Admin::ProductsController < AdminController
  layout "admin"
  
  def index
    @products = Product.all
    @product = Product.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  def edit
    @products = Product.all
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(params[:product])
    @product.status = "上架"

    respond_to do |format|
      if @product.save
        @stock = @product.stocks.new
        @stock.typename = "default"
        @stock.amount = nil

        @stock.save

        format.html { redirect_to  stock_admin_product_path(@product), notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        @products = Product.all
        format.html { render action: "index" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to edit_admin_product_path(@product), notice: ( @product.name + '已更新。') }
        format.json { head :no_content }
      else
        @products = Product.all
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def enable
    @product = Product.find(params[:id])
    @product.status = "上架"
    @product.save

    respond_to do |format|
      format.html { redirect_to edit_admin_product_path(@product) }
      format.json { render json: @product }
    end
    
  end

  def disable
    @product = Product.find(params[:id])
    @product.status = "下架"
    @product.save

    respond_to do |format|
      format.html { redirect_to edit_admin_product_path(@product) }
      format.json { render json: @product }
    end
    
  end
end
