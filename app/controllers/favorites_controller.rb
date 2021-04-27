class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    #すでに生成されているmicropostを利用するため，インスタンス変数とはしない(?)。
    micropost = Micropost.find(params[:micropost_id])
    current_user.favorite(micropost)
    flash[:success] = '投稿をお気に入りに登録しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    #すでに生成されているmicropostを利用するため，インスタンス変数とはしない(?)。
    micropost = Micropost.find(params[:micropost_id])
    current_user.unfavorite(micropost)
    flash[:success] = '投稿をお気に入りから解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
