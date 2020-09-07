class ApplicationController < ActionController::Base
    # コントローラとビューの両方から利用する機会があるので、helper_methodでメソッド名を宣言する
    helper_method :logged_in?

    private

    def logged_in?
        !!session[:user_id]
    end
end
