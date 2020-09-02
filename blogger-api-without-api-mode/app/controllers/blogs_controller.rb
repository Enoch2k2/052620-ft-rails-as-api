class BlogsController < ApplicationController
  before_action :set_blog, only: [:show]
  skip_before_action :verify_authenticity_token, only: [:create, :update]

  def index
    @blogs = Blog.all

    respond_to do |format|
      format.html
      format.json { render json: @blogs }
    end
  end
  
  def show
    respond_to do |format|
      format.html
      format.json { render json: @blog, except: [:id] }
    end
  end

  def new
    @blog = Blog.new
  end
  
  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      respond_to do |format|
        format.html { redirect_to blogs_path }
        format.json { render json: @blog }
      end  
    else
      respond_to do |format|
        format.html { render :new }
        format.json do
           render json: { errors: @blog.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end
  end

  private
    def set_blog
      @blog = Blog.find_by_id(params[:id])
    end

    def blog_params
      params.require(:blog).permit(:title, :content)
    end
end
