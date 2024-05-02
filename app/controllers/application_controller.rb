class ApplicationController < ActionController::API
    
    def current_user
      @current_user ||= Account.find(decoded_token["id"]) if decoded_token
    end
  
    rescue_from ActiveRecord::RecordNotFound, :with => :not_found
    private
    
    def not_found
      render :json => {'errors' => {"message" =>'Record not found'}}, :status => :not_found
    end


    def authenticate_request
      @current_user = current_user
      render json: { error: 'Not Authorized' }, status: 401 unless @current_user
    end
  
    def decoded_token
      @decoded_token ||= AuthService.decode_token(retrive_token)
    end
  
    def retrive_token
       token = request.headers[:token] || params[:token]
    end
end
