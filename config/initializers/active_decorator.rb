ActiveDecorator.configure do |config|
    # 設定しない場合、#{対象のモデル名}Decoratorになる
    config.decorator_suffix = "Presenter"
end
