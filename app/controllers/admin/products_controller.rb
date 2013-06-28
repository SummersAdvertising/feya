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

  def show
    @product = Product.find(params[:id])
    @product["hasType"] = (@product.stocks.first.typename != "default")

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
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
        if(params[:type])
          params[:type].each do |type|
            @stock = Stock.new
            @stock.product_id = params[:id]
            @stock.typename = type
            @stock.amount = nil

            @stock.save
          end
        end
        
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

    if(params[:type])
      params[:type].each do |type|
        @stock = Stock.new
        @stock.product_id = params[:id]
        @stock.typename = type
        @stock.amount = nil

        @stock.save
      end
    end

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

  def stock
    @product = Product.find(params[:id])    
  end

  def saveStock
    params[:stock].each do |stock|
      @stock = Stock.find(stock[0])
      @stock.amount = stock[1]

      @stock.save
    end

    respond_to do |format|
      format.html { redirect_to stock_admin_product_path(params[:id]), notice: ( '商品庫存已更新。') }
    end

  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to admin_products_path }
      format.json { head :no_content }
    end
  end
end
