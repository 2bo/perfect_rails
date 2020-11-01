require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  test "自分が作ったイベントは削除できる" do
    event_owner = FactoryBot.create(:user)
    event = FactoryBot.create(:event, owner: event_owner)
    sign_in_as event_owner
    assert_difference("Event.count", -1) do
      delete event_url(event)
    end
  end

  test "他の人が作ったイベントは削除できない" do
    event_owner = FactoryBot.create(:user)
    event = FactoryBot.create(:event, owner: event_owner)
    sign_in_user = FactoryBot.create(:user)
    sign_in_as sign_in_user
    assert_difference("Event.count", 0) do
      delete event_url(event)
      # 8章の最後でapplication_controllerに例外処理を追加したためテストが失敗する。コメントアウトで回避
      # assert_raises(ActiveRecord::RecordNotFound) do
      #   delete event_url(event)
      # end
    end
  end
end
