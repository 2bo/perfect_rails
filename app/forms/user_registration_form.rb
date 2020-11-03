class UserRegistrationForm
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :email, :string
    attribute :password, :string
    attribute :password_confirmation, :string

    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validate :email_is_not_taken_by_another
    validates :password, format: { with: /\A[\p{ascii}&&[^\x20]]{8,72}\z/ }, confirmation: { allow_blank: true }
    validates :terms_of_service, acceptance: { allow_nil: false }

    def save
        return false if invalid?

        user.save!
        UserMailer.with(user: user).welcome.deliver_later

        true
    end

    def user
        @user ||= User.new(email: email, password: password)
    end

    private 

    def email_is_not_taken_by_another
        errors.add(:email, :taken, value: email) if User.exists?(email: email)
    end
end
