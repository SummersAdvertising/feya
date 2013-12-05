class Admin::EntriesController < AdminController
  # GET /admin/entries
  # GET /admin/entries.json
  def index
    @entries = Entry.all

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
  def new
    @entry = Entry.new(params[:admin_entry])
    @entry.article = Article.new

    respond_to do |format|
      if @entry.save
        format.html { redirect_to edit_admin_entry_path(@entry), notice: 'Entry was successfully created.' }
        format.json { render json: @entry, status: :created, location: @entry }
      else
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
      if @entry.update_attributes(params[:entry]) && ( params[ :article ].nil? ^ @entry.article.update_attributes( params[ :article ] ) )
        format.html { redirect_to admin_entry_path(@entry), notice: 'Entry was successfully updated.' }
        format.json { head :no_content }
      else
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
      format.html { redirect_to admin_entries_url }
      format.json { head :no_content }
    end
  end
end
