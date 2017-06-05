
class ApplicationController < ActionController::Base
    
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

      def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name

    devise_parameter_sanitizer.for(:sign_up) << :gender
    devise_parameter_sanitizer.for(:account_update) << :gender

    devise_parameter_sanitizer.for(:sign_up) << :status
    devise_parameter_sanitizer.for(:account_update) << :status

    devise_parameter_sanitizer.for(:sign_up) << :dob
    devise_parameter_sanitizer.for(:account_update) << :dob

    devise_parameter_sanitizer.for(:sign_up) << :userimage
    devise_parameter_sanitizer.for(:account_update) << :userimage
  end
end


