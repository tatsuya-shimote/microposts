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
  
  def counts(user)
    @count_microposts = user.microposts.count
  end
end
