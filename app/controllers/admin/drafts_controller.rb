# encoding: utf-8
class Admin::DraftsController < AdminController


  # PUT /drafts/1
  # PUT /drafts/1.json
  def update
    @draft = Draft.find(params[:id])
    
    respond_to do |format|
      if @draft.update_attributes(params[:draft])
      	#flash[ :notice ] = '草稿更新完成.'
        format.js { }
      else
      	flash[ :warning ] = '草稿更新出錯囉！'
        format.js { }
      end
    end
  end

  # DELETE /drafts/1
  # DELETE /drafts/1.json
  def destroy
    @draft = Draft.find(params[:id])
    @draft.destroy

    #delete the photo directory
    require "fileutils"
    FileUtils.rm_rf "public/uploads/" + params[:id]

    respond_to do |format|
      format.html { redirect_to drafts_path }
    end
  end
end
