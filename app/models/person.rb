class Person
    # ActiveModelが提供するモジュール郡の一部をまとめたモジュール
    # オブジェクトをコントローラーやビューのメソッドで利用できるようになる
    include ActiveModel::Model

    # バリデーション機能を提供してくれるモジュール
    include ActiveModel::Validations
    # before_validation,after_validationコールバックを利用するのに必要
    include ActiveModel::Validations::Callbacks

    # シリアライズ機能を提供してくれるモジュール
    include ActiveModel::Serialization
    include ActiveModel::Serializers::JSON

    # 型の持つ属性定義を用意にしてくれるモジュール
    include ActiveModel::Attributes

    # コールバック機能の実装を容易にしてくれるモジュール
    extend ActiveModel::Callbacks

    attribute :name, :string
    attribute :age, :integer
    attr_accessor :created_at, :updated_at

    validates :name, presence: true, length: { maximum: 100 }
    validates_numericality_of :age, greater_then_or_equal_to: 0

    # コールバック対象メソッドの指定
    define_model_callbacks :save
    # 上記の指定により使えるようになる
    before_save :record_timestamps

    before_validation :normalize_name, if: -> { name.present? }

    def save
        run_callbacks :save do
            # saveメソッドの中身をここに記述する
            true
        end
    end

    # serializable_hashはattributesメソッドがあることを前提としている
    def attributes
        # シリアライズの必要がある属性名の文字列をキーとするハッシュを返す必要がある
        { "name" => name, "age" => age }
    end

    def to_xml(options = nil)
        serializable_hash(options).to_xml(camelize: :lower, root: self.class.name)
    end

    private

    def record_timestamps
        current_time = Time.current

        self.created_at ||= current_time
        self.updated_at = current_time
    end

    def normalize_name
        self.name = name.downcase.titleize
    end
end
