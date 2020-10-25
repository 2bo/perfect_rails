require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400] do |options|
    #パーフェクトRoRには記載がない。Dockerのrootユーザで実行するために追加
    options.add_argument('--no-sandbox') 
  end
  include SignInHelper
end
