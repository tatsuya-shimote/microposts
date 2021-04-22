
class ApplicationController < ActionController::Base
  #全ての Controllerで以下のログイン認証アクションを実行したいのでこのファイルに定義する。
  #なぜなら，ApplicationControllerは全てのControllerに継承されているから。
  private

  def require_user_logged_in
    #unlessはifの反対で，条件がfalseのとき実行される。
    unless logged_in?
      redirect_to login_url
    end
  end
end
