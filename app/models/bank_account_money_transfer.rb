class BankAccountMoneyTransfer < ApplicationRecord
    composed_of :money, mapping: [%w[amount amount], %w[currency currency]]

    belongs_to :from, class_name: "BankAccount"
    belongs_to :to, class_name: "BankAccount"

    validate :attributes_can_be_represented_as_money
    before_create :transfer_money

    private

    def attributes_can_be_represented_as_money
        # Moneyオブジェクトを初期化できるかどうかを確かめる
        money
    rescue
        self.class.reflect_on_aggregation(:money).mapping.each do |attribute, _|
            errors.add(attribute, :invalid)
        end
    end

    def transfer_money
        from.withdraw(money)
        to.deposit(money)
    end
end
