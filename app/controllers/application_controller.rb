class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  # CSRF対策（Rails標準）
  protect_from_forgery with: :exception
  # セッションタイムアウトの設定
  before_action :check_session_timeout, :require_login

  private

  def not_authenticated
    redirect_to root_path
  end

  def check_session_timeout
    return unless current_user

    # 初回アクセス時の処理
    unless session[:last_activity]
      session[:last_activity] = Time.current
      return
    end

    # タイムアウトチェック
    if session[:last_activity] < 30.minutes.ago
      logout
      session.clear  # セッション情報を完全にクリア
      redirect_to login_path, alert: "セキュリティのため自動ログアウトしました"
    else
      # 活動時刻を更新
      session[:last_activity] = Time.current
    end
  end
end
