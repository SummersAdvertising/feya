#encoding: UTF-8
class Admin::ProductsController < AdminController
  layout "admin"

  before_filter :get_category
  
  def index
    @products = Product.where( "delete_flag IS NULL ").order("created_at DESC").page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  def edit
    @products = Product.order("created_at DESC").page(params[:page])
    @product = Product.find(params[:id])
  end
  
  def new
    @product = Product.new
    @product.status = "下架"
    @product.price = 0

    @product.article = Article.new

    @photo = Photo.new
    respond_to do |format|
      if @product.save
        @stock = @product.stocks.new
        @stock.typename = "default"
        @stock.amount = nil

        @stock.save

        format.html { redirect_to  edit_admin_category_product_path(@product), notice: '成功建立商品' }
        format.json { render json: @product, status: :created, location: @product }
      else
        @products = Product.order("created_at DESC").page(params[:page])
        format.html { render action: "index" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @product = @category.products.build(params[:product])
    @product.status = "下架"

    @product.article = Article.new
    @product.name = '未命名商品'
    @product.price = 0

    @photo = Photo.new


    respond_to do |format|
      if @product.save
        @stock = @product.stocks.new
        @stock.typename = "default"
        @stock.amount = nil

        @stock.save
        
        format.html { redirect_to  edit_admin_category_product_path(@category, @product), notice: '成功建立商品' }
        format.json { render json: @product, status: :created, location: @product }
      else
      
      	flash[ :warning ] = @product.errors.messages.values.flatten.join('<br>')
      
        @products = Product.order("created_at DESC").page(params[:page])
        format.html { render action: "index" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @product = Product.find(params[:id])
    
    
    respond_to do |format|
      if @product.update_attributes(params[:product]) && @product.article.update_attributes( params[ :article ] )
        format.html { redirect_to edit_admin_category_product_path(@category, @product, :page => params[:page]), notice: ( @product.name + '已更新。') }
        format.json { head :no_content }
      else
      
	    flash[ :warning ] = @product.errors.messages.values.flatten.join('<br>')
      
        @products = Product.order("created_at DESC").page(params[:page])
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
  	@product = Product.find( params[ :id ] )
  	@product.update_attribute(:delete_flag, true)
  	
  	respond_to do | format |
  		format.html { redirect_to admin_category_path( @category ), notice: "商品刪除完成" }
  	end
  end


  def enable
    @product = Product.find(params[:id])
    @product.status = "上架"
    @product.save

    respond_to do |format|
      format.html { redirect_to edit_admin_category_product_path(@category, @product, :page => params[:page]), notice: "商品上架完成" }
      format.json { render json: @product }
    end
    
  end

  def disable
    @product = Product.find(params[:id])
    @product.status = "下架"
    @product.save

    respond_to do |format|
      format.html { redirect_to edit_admin_category_product_path(@category, @product, :page => params[:page]), notice: "商品下架完成" }
      format.json { render json: @product }
    end
    
  end
  
private
	def get_category
		@category = Category.find( params[ :category_id ] )
		@categories = Category.order( 'lft ASC, created_at ASC' ).all
	end  
  
end
