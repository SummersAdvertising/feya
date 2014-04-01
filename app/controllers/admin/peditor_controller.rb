class Admin::PeditorController < AdminController


  #create photo
  def createPhoto
    @photo = Photo.new(params[:photo])
    @photo.article_id = params[:id]
    @photo.status = 'drafting'

    respond_to do |format|
      if @photo.save
        format.json { render json: @photo, status: :created, location: @photo }
        format.js
      else
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroyPhoto
    @photo = Photo.find(params[:id])
    @photo.mark_deleting

    respond_to do |format|
          format.html { redirect_to :controller => 'photos', :action => 'index' }
          format.js
          format.json { head :no_content }
      end
  end


end