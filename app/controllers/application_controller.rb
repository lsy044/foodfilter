class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    # protect_from_forgery with: :exception
    protect_from_forgery prepend: true
    protected
   
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :gender, :email, :IDe, :password,:profileimg, :ages, :isExpert, :allergy_etc, allergy:[] ] )
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :gender, :email, :IDe, :password,:profileimg, :ages, :isExpert, :allergy_etc, allergy:[] ])
    end
  end
  