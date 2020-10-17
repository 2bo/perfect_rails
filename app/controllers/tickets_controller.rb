class TicketsController < ApplicationController
    def new
        # authenticateメソッドが事項されトップページに遷移するこを期待
        # 直接URLを開いた場合エラーをraise
        raise ActionController::RoutingError, "ログイン状態でTicketController#newにアクセス"
    end

    def create
        event = Event.find(params[:event_id])
        @ticket = current_user.tickets.build do |t|
            t.event = event
            t.comment = params[:ticket][:comment]
        end
        if @ticket.save
            redirect_to event, notice: "このイベントに参加表明しました"
        end
    end

    def destroy
        # ビューに渡す変数が存在しないためインスタンス変数をつかっていない
        # 存在しないevnet_idが渡されたときにNotFundErorrを発生させ404ページを表示するため!付きメソッド
        ticket = current_user.tickets.find_by!(event_id: params[:event_id])
        # 削除時のコールバックで削除を中止したときに例外を発生させる
        ticket.destroy!
        redirect_to event_path(params[:event_id]), notice: "このイベントの参加をキャンセルしました"
    end
end
