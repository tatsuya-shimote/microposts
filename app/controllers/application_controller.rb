class ApplicationController < ActionController::Base
  #HelperをControllerでも利用できるようにする。
  include SessionsHelper
  #全ての Controllerで以下のログイン認証アクションを実行したいのでこのファイルに定義する。
  #なぜなら，ApplicationControllerは全てのControllerに継承されているから。
  private

  def require_user_logged_in
    #unlessはifの反対で，条件がfalseのとき実行される。
    unless logged_in?
      redirect_to login_url
    end
  end
  
  #投稿数，フォロー数，フォロワー数のカウント
  def counts(user)
    @count_microposts = user.microposts.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_favorites = user.likes.count
  end
end
