# encoding: utf-8
class Admin::EntriesController < AdminController
  # GET /admin/entries
  # GET /admin/entries.json
  def index
    @entries = Entry.order( "created_at DESC" ).page( params[ :page ] ).per(20)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entries }
    end
  end

  # GET /admin/entries/1
  # GET /admin/entries/1.json
  def show
    @entry = Entry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @entry }
    end
  end

  # GET /admin/entries/new
  # GET /admin/entries/new.json
  def create
    @entry = Entry.new
    @entry.article = Article.new
    @entry.title = "未命名新聞"

    respond_to do |format|
      if @entry.save
        format.html { redirect_to edit_admin_entry_path(@entry), notice: '成功建立最新消息' }
        format.json { render json: @entry, status: :created, location: @entry }
      else
      	flash[ :warning ] = @entry.errors.messages.values.flatten.join('<br>')
        format.html { render action: "new" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /admin/entries/1/edit
  def edit
    @entry = Entry.find(params[:id])
  end

  # PUT /admin/entries/1
  # PUT /admin/entries/1.json
  def update
    @entry = Entry.find(params[:id])

    respond_to do |format|
      if @entry.update_attributes(params[:entry]) && ( params[ :entry ][ :article ].nil? ^ @entry.article.update_attributes( params[ :entry ][ :article ] ) )
        format.html { redirect_to admin_entries_path, notice: '最新消息已更新' }
        format.json { head :no_content }
      else
      
      	flash[ :warning ] = @entry.errors.messages.values.flatten.join('<br>')
      	
        format.html { render action: "edit" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/entries/1
  # DELETE /admin/entries/1.json
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to admin_entries_url, notice: "該筆最新消息已經成功刪除" }
      format.json { head :no_content }
    end
  end
end
