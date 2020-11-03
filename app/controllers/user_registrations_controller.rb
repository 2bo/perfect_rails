class UserRegistrationsController < ApplicationController
    def new
        @user_registration_form = UserRegistrationForm.new
    end

    def create
        @user_registration_form.new(user_registration_form_params)

        if @user_registration_form.save
            sign_in(@user_registration_form.user)
            redirect_to action::completed
        else
            render :new
        end
    end

    def completed; end

    private
    
    def user_registration_form_params
        params.require(:user_registration_form).permit(
            :email,
            :password,
            :password_confirmation,
            :terms_of_service
        )
    end
end
