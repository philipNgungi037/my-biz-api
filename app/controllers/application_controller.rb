class ApplicationController < ActionController::API
    before_action :authorize_request

    def current_user
      @current_user
    end
  
    private
  
    def authorize_request
      header = request.headers['Authorization']
      token = header.split(' ').last if header
      begin
        decoded = JsonWebToken.decode(token)
        @current_user = User.find(decoded[:user_id])
      rescue ActiveRecord::RecordNotFound, JWT::DecodeError
        render json: { errors: 'Unauthorized access' }, status: :unauthorized
      end
    end
end
