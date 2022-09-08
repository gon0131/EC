# frozen_string_literal: true

class Customer::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :customer_state, only: [:create]

  def after_sign_in_path_for(resource)
    customers_my_page_path
  end
  
  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :phone_number, :address])
  end
  
  def customer_state
    @customer = Customer.find_by(email: params[:customer][:email])
    return if !@customer
    if @customer.valid_password?(params[:customer][:password]) && @customer.is_deleted == true
      redirect_to new_customer_registration_path
    end
  end

end
