class Money
    include Comparable
    
    attr_reader :amount, :currency
    alias eql? ==

    def initialize(amount, currency = :JPY)
        @amount = BigDecimal(amount)
        raise "Amount must not be negative" if @amount.negative?

        @currency = currency.to_sym
    end

    def <=>(other)
        return nil if self.class != other.class || currency != other.currency
        amount <=> other.amount
    end

    def +(other)
        raise "Currency is different" unless currency == other.currency
        self.class.new(amount + other.amount, currency)
    end

    def -(other)
        raise "Currency is different" unless currency == other.currency
        self.class.new(amount - other.amount, currency)
    end

    def hash
        [amount, currency].hash
    end
end
