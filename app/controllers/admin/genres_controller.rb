class Admin::GenresController < ApplicationController
  
  # ログイン中の管理者のみアクセス許可
  before_action :authenticate_admin!

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path
      flash[:notice] = "新しいジャンルを登録しました。"
    else
      @genres = Genre.all
      render 'index'
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path
      flash[:notice] = "ジャンルの情報を変更しました。"
    else
      render 'edit'
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name, :is_active)
  end

end
