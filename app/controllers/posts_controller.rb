class PostsController < ApplicationController
  before_filter :require_user
  before_filter :find_post, :only => [:show,:edit,:update,:destroy]
  
  def index
    @posts = Post.all
    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  
  def show    
    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end

  
  def new
    @post = current_user.posts.new
    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end

  
  def edit    
  end
  
  def create
    @post = Post.new(params[:post])
    respond_to do |format|
      if @post.save
        PrivatePub.publish_to("/posts", {html_content: render_to_string(:partial => "posts/post", :locals => {:post => @post, :publish => true}), id: @post.id}) rescue nil
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def update    
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def destroy    
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  def find_post
    @post = Post.find(params[:id])
  end  
end
