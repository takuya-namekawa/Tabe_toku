class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @admin = current_admin
    @genre = Genre.new(genre_params)
    # @genre.admin_id = @admin.id
    @genre.save!
    redirect_to admin_genres_path
  end

  def edit
    @genre = Genre.find(params[:id])
      # if @genre.admin != current_admin
      #   redirect_to root_path, alert: "不正なアクセスです"
      # end
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: "ジャンル名を更新しました"
    else
      render "admin/genres/edit"
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to admin_genres_path, notice: "ジャンルを削除しました"
  end
  
  private
    def genre_params
      params.require(:genre).permit(:name)
    end  
end
