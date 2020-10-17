class ApplicationController < ActionController::Base
    # 複数のコントローラで使用する汎用的な機能は一般的にApplicationControllerに記述する
    before_action :authenticate
    # コントローラとビューの両方から利用する機会があるので、helper_methodでメソッド名を宣言する
    helper_method :logged_in?, :current_user

    private

    def logged_in?
        !!current_user
    end

    def current_user
        return unless session[:user_id]
        @current_user ||= User.find(session[:user_id])
    end

    def authenticate
        return if logged_in?
        redirect_to root_path, alert: "ログインしてください"
    end
end
