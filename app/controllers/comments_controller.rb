class CommentsController < ApplicationController
  load_and_authorize_resource
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = current_user.comments.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end


  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  def forresource
    resource_id = params[:id]
    @comments = Comment.where(:resource_id => resource_id)
    respond_to do |format|
        format.html { redirect_to :back, notice: "Thank you for voting" }
        format.json { render :status=>200, :json=>{:success=>true, :comments => @comments}}
    end
  end

  # POST /comments
  # POST /comments.json
  def create
    resource_id = params[:resource]
    r = Resource.find(resource_id)
    @comment = Comment.new(:user_id => current_user.id, :resource_id => resource_id, :content => params[:content])
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        @comments = Comment.where(:resource_id => params[:resource])
        format.json { render :status=>200, :json=>{:success=>true, :comments => @comments}}
        @comment.create_activity :create, owner: current_user, recipient: r
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end
end
