class PathsController < ApplicationController

  # GET /paths
  # GET /paths.json
  def index
    @paths = Path.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @paths }
    end
  end

  def ajaxPaths
     @paths = Path.all
     render :partial => "pathsPartial"
  end
  # GET /paths/1
  # GET /paths/1.json
  def show
    @path = Path.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @path }
    end
  end

  # GET /paths/new
  # GET /paths/new.json
  def new
    require_login

    @path = current_user.paths.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @path }
    end
  end

  # GET /paths/1/edit
  def edit
    require_login

    @path = Path.find(params[:id])
  end

  # POST /paths
  # POST /paths.json
  def create
    require_login
    @user = current_user
    @path = @user.paths.new(params[:path])

    respond_to do |format|
      if @path.save
        format.html { redirect_to @path, notice: 'Path was successfully created.' }
        format.json { render json: @path, status: :created, location: @path }
      else
        format.html { render action: "new" }
        format.json { render json: @path.errors, status: :unprocessable_entity }
      end
    end
    if !current_user.nil?
      if(!current_user.facebook.access_token.nil?)
        current_user.facebook.put_wall_post("I just created a learning path for myself on www.knowledgethief.com")
      end
    end
  end

  # PUT /paths/1
  # PUT /paths/1.json
  def update
    require_login

    @path = Path.find(params[:id])

    respond_to do |format|
      if @path.update_attributes(params[:path])
        format.html { redirect_to @path, notice: 'Path was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @path.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paths/1
  # DELETE /paths/1.json
  def destroy
    require_login

    @path = Path.find(params[:id])
    @path.destroy

    respond_to do |format|
      format.html { redirect_to paths_url }
      format.json { head :no_content }
    end
  end
 
  private
 
  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_user_session_path # halts request cycle
    end
  end
 
  def logged_in?
    !!current_user
  end

end
