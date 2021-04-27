module SessionsHelper
  
  #def current_userは以下のif文を1行で書いたもの。
  # if @current_user
  #   return @current_user
  # else
  #   @current_user = User.find_by(id: session[:user_id])
  #   return @current_user
  # end
  def current_user
    #@current_userにログインユーザーが格納されていればそのまま
    #格納されていなければUser.find_by(id: session[:user_id])でユーザを検索し格納する。
    @current_user ||= User.find_by(id: session[:user_id])
  end

  #def logged_in?は以下のif文と同じ
  # if current_user
  #   return true
  # else
  #   return false
  # end
  def logged_in?
    !!current_user
  end
end
