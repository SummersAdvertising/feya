#encoding: UTF-8
class Admin::StocksController < AdminController
  layout "admin"
  
  before_filter :get_product
  
  def index
    @product = Product.find(params[:product_id])
    @stocks = @product.stocks
    @stock = Stock.new
  end

  def create
    @product = Product.find(params[:product_id])
    @default = @product.stocks.where(['typename = ?', "default"]).first
    @default.destroy if @default
    
    @stock = @product.stocks.new
    @stock.typename = params[:stock][:typename]
    
    if(@stock.save)
      respond_to do |format|
        format.html { redirect_to edit_admin_category_product_path(@category, params[:product_id]), notice: ( '已新增產品種類: '+@stock.typename+'。') }
      end
    else
	    flash[ :warning ] = @stock.errors.messages.values.flatten.join('<br>')
      
      respond_to do |format|
        format.html { redirect_to edit_admin_category_product_path(@category, params[:product_id]), alert: (@stock.typename.length > 0 ? '此分類已存在。' : '請輸入分類名稱。') }
      end
    end
  end

  def updateStocks
    params[:stock].each do |stock|
      @stock = Stock.find(stock[0])
      @stock.amount = stock[1]

      @stock.save
    end

    respond_to do |format|
      format.html { redirect_to edit_admin_category_product_path(@category, @product), notice: ( '商品庫存已更新。') }
    end
  end

  def destroy
    @stock = Stock.find(params[:id])
    @stock.destroy

    @product = Product.find(params[:product_id])

    if(@product.stocks.count == 0)
      @stock = @product.stocks.new
      @stock.typename = "default"
      @stock.save
    end

    respond_to do |format|
      format.html { redirect_to edit_admin_category_product_path(@category, params[:product_id]), notice: ( '已刪除庫存種類。')  }
    end    
  end
  
private
	def get_product
		@product = Product.find( params[ :product_id ] )
		@category = Category.find( params[ :category_id ] )
	end  
  
end


