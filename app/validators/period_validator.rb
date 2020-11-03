class PeriodValidator < ActiveModel::Validator
    def initialize(options = {})
        super({ from: :from, to: :to }.merge!(options))
    end

    # recordはバリデーション対象のオブジェクト
    def validate(record)
        from = record.read_attribute_for_validation(options[:from])
        to = record.read_attribute_for_validation(options[:to])

        if to < from
            # エラーが特定の属性に関するものでなければ、:baseを指定する
            record.errors.add(:base, "Period from #{from} to #{to} is invalid")
        end
    end
end
