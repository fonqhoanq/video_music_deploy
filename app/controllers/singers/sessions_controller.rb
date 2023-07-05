# app/controllers/singers/sessions_controller.rb
class Singers::SessionsController < Devise::SessionsController
    respond_to :json
    skip_before_action :verify_authenticity_token

    private
  
    def respond_with(_resource, _opts = {})
      return login_success if current_singer
    
      login_failed
    end
  
    def respond_to_on_destroy
      log_out_success && return if current_singer
  
      log_out_failure
    end
  
    def login_success
      # current_singer
      render json: {
        message: 'You are logged in.',
        singer: current_singer
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
  