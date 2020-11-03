class CreateBankAccountMoneyTransfers < ActiveRecord::Migration[6.0]
  def change
    create_table :bank_account_money_transfers do |t|
      t.bigint :from_id, null: false
      t.bigint :to_id, null: false
      t.decimal :amount, precision: 19, scale: 4, null: false
      t.string :currency, null: false
      t.timestamps
    end
  end
end
