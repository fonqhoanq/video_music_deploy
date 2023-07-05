# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController
    respond_to :json
    skip_before_action :verify_authenticity_token

    private
  
    def respond_with(_resource, _opts = {})
      return login_success if current_user
    
      login_failed
    end
  
    def respond_to_on_destroy
      log_out_success && return if current_user
  
      log_out_failure
    end
  
    def login_success
      # current_user
      render json: {
        user: current_user,
        avatarUrl: url_for(current_user.avatar)
      }, status: :ok
    end
    
    def login_failed
      render json: { message: 'Login failed' }, status: :unauthorized
    end

    def log_out_success
      render json: { message: 'You are logged out.' }, status: :ok
    end
  
    def log_out_failure
      render json: { message: 'Hmm nothing happened.' }, status: :unauthorized
    end
  end
  