class Admin::TestimoniesController < AdminController
  # GET /admin/testimonies
  # GET /admin/testimonies.json
  def index
    @testimonies = Testimony.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @testimonies }
    end
  end
  
  # GET /admin/testimonies/new
  # GET /admin/testimonies/new.json
  def create
    @testimony = Testimony.new
    @testimony.article = Article.new

    respond_to do |format|
      if @testimony.save
        format.html { redirect_to edit_admin_testimony_path(@testimony), notice: 'Testimony was successfully created.' }
        format.json { render json: @testimony, status: :created, location: @testimony }
      else
        format.html { render action: "index" }
        format.json { render json: @testimony.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /admin/testimonies/1/edit
  def edit
    @testimony = Testimony.find(params[:id])
  end

  # PUT /admin/testimonies/1
  # PUT /admin/testimonies/1.json
  def update
    @testimony = Testimony.find(params[:id])

    respond_to do |format|
      if @testimony.update_attributes(params[:testimony]) && ( params[ :article ].nil? ^ @testimony.article.update_attributes( params[ :article ] ) )
        format.html { redirect_to admin_testimonies_path, notice: 'Testimony was successfully updated.' }
        format.js { head :no_content }
      else
        format.html { render action: "edit" }
        format.js { render json: @testimony.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/testimonies/1
  # DELETE /admin/testimonies/1.json
  def destroy
    @testimony = Testimony.find(params[:id])
    @testimony.destroy

    respond_to do |format|
      format.html { redirect_to admin_testimonies_path }
      format.json { head :no_content }
    end
  end
end
