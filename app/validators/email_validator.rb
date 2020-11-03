class EmailValidator < ActiveModel::EachValidator
    # record: バリデーション対象のオブジェクト
    # attribute: 対象の属性名
    # value: 対象の属性の値
    def validate_each(record, attribute, value)
        unless value =~ URI::MailTo::EMAIL_REGEXP
            # ルールを満たさない場合、erros属性のメソッドを呼び出してエラーを追加する必要がある
            record.erros.add(attribute, :invalid, options.merge(value: value))
        end
    end
end
