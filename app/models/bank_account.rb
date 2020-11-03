class BankAccount < ApplicationRecord
    composed_of :balance, class_name: "Money", mapping: [%w[balance amount], %w[currency currency]]

    def deposit(money)
        with_lock { update!(balance: balance + money) }
    end

    def withdraw(money)
        with_lock_do
            raise "Withdrawal amount must not be greater than balance" if money > balance
            update!(balance: balance - money)
        end
    end
end
