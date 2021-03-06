class FlagsController < InheritedResources::Base
  def index
    @flags = Flag.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @flags }
    end
  end

=begin
  # GET /flags/1
  # GET /flags/1.json
  def show
    @flag = Flag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @flag }
    end
  end
=end

  # GET /flags/new
  # GET /flags/new.json
  def new
    @flag = Flag.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @flag }
    end
  end

  # GET /flags/1/edit
  def edit
    @flag = Flag.find(params[:id])
  end

  # POST /flags
  # POST /flags.json
  def create
  	#raise type
    #@flag = Flag.new(params[:flag])
    @flag = Flag.new(:itemtype => "resource", :item_id => params[:resource], :reporter_id => current_user.id, :desc => params[:content], :checked => false,
  	:resolved => false)
    #@flag = @flag.create_flag()
    respond_to do |format|
      if @flag.save
        format.html { redirect_to @flag, notice: 'flag was successfully created.' }
        format.json { render json: @flag, status: :created, location: @flag }
      else
        format.html { render action: "new" }
        format.json { render json: @flag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /flags/1
  # PUT /flags/1.json
=begin
  def update
    @flag = Flag.find(params[:id])

    respond_to do |format|
      if @flag.update_attributes(params[:flag])
        format.html { redirect_to @flag, notice: 'flag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @flag.errors, status: :unprocessable_entity }
      end
    end
  end
=end

  # DELETE /flags/1
  # DELETE /flags/1.json
  def destroy
    @flag = Flag.find(params[:id])
    @flag.destroy

    respond_to do |format|
      format.html { redirect_to flags_url }
      format.json { head :no_content }
    end
  end

  def show
  	@flag = Flag.find(params[:id])
  	@flag.update_attributes(:action => "takedown", :moderator_id => current_user.id)

  	@resource = Resource.find(params[:resource])
  	@resource.update_attributes(:active => false)
  	redirect_to flags_path
  end

end
