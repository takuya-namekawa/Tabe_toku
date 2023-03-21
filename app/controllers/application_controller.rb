class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  private
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [ :email, :password_confirmation, :name, :name_kana, :phone_number, :address, ])
    end
end
