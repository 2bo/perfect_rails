class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      # 退会時にnullにするためnull許可
      t.references :user
      # 以下で復号インデックスを定義するのでevent_id単体のインデックスは不要
      t.references :event, null: false, foreign_key: true, index: false
      t.string :comment

      t.timestamps
    end

    add_index :tickets, %i[event_id user_id], unique: true
  end
end
