class BlogsController < ApplicationController

  def index
    @blogs = Blog.all
    render json: @blogs # , include: [:user] adds user association to the json
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      render json: @blog, status: :created
    else
      render json: @blog.errors.full_messages, status: :unprocessable_entity
    end
  end

  private
    def blog_params
      params.require(:blog).permit(:title, :content)
    end
end
