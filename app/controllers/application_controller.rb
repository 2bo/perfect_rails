class ApplicationController < ActionController::Base
    # 複数のコントローラで使用する汎用的な機能は一般的にApplicationControllerに記述する
    before_action :authenticate
    # コントローラとビューの両方から利用する機会があるので、helper_methodでメソッド名を宣言する
    helper_method :logged_in?, :current_user

    # rescue_fromはあとに登録した順に判定するので、順番に注意。Exceptionを最後にすると、すべてのエラーがマッチしてしまう
    rescue_from Exception, with: :error500
    rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError, with: :error404

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

    def error404(e)
        render "error404", status: 404, formats: [:html]
    end

    def error500(e)
        logger.error [e, *e.backtrace].join("\n")
        render "error500", status: 500, formats: [:html]
    end
end
