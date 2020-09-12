class Ticket < ApplicationRecord
  # optional: trueを追加して関連先がなくてもバリデーションエラーにならないようにする
  belongs_to :user, optional: true
  belongs_to :event

  # 空文字、nullを許可する
  validates :comment, length: { maximum: 30 }, allow_blank: true
end
