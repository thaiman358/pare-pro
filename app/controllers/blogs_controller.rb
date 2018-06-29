class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy] # destroyアクションを追加
  def index
    @blogs = Blog.all # 全部表示する
  end
  
  # /newのリクエストを受け取った時の処理
  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end
  
  # 作成
  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to blogs_path
    else
      render 'new'
    end
  end
  
  # 確認画面
  def confirm
    @blog = Blog.new(blog_params)
    render :new if @blog.invalid?
  end
  
  # 詳細画面
  def show
    @blog = Blog.find(params[:id])
  end
  
  # 編集画面
  def edit
    @blog = Blog.find(params[:id])
  end
  
  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      render 'show'
    else
      render 'edit'
    end
  end
  
  # ブログの削除機能
  def destroy
    @blog.destroy
    redirect_to blogs_path
  end
  
  private
  def blog_params
    params.require(:blog).permit(:title, :content)
  end
  
  def set_blog
  @blog = Blog.find(params[:id])
  end
end