# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
    respond_to :json
    skip_before_action :verify_authenticity_token

    private
  
    def respond_with(resource, _opts = {})
      register_success && return if resource && resource.persisted?
  
      register_failed
    end
  
    def register_success
      render json: {
        message: 'Signed up sucessfully.',
        user: current_user
      }, status: :ok
    end
  
    def register_failed
      render json: { message: 'Something went wrong.' }, status: :unprocessable_entity
    end
  end
  