class EventSearchForm
    # モデルとして必要な振る舞いの追加
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :keyword, :string
    attribute :page, :integer

    def search
        # Event.searchはsearchkickで検索するメソッド
        # searchkickはデフォルトでkaminariに対応している。pageとper_pageを渡すだけでよい
        Event.search(
            keyword_for_search,
            where: { start_at: { gt: start_at }},
            page: page,
            per_page: 10
        )
    end

    def start_at
        @start_at || Time.current
    end

    def start_at=(new_start_at)
        # 文字で入力された日時をActiveSupport::TimeWithZoneオブジェクトに変換する
        @start_at = new_start_at.in_time_zone
    end

    private

    def keyword_for_search
        # *はすべての検索結果で表示されるようになる
        keyword.presence || "*"
    end
end
