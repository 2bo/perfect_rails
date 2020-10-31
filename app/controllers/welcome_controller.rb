class WelcomeController < ApplicationController
  skip_before_action :authenticate

  def index
    # 未開催のイベントを開催時間が近い順に取得
    @events = Event.page(params[:page]).per(10).
    where("start_at > ?", Time.zone.now).order(:start_at)
  end
end
