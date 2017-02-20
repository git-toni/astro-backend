require 'jwt'

module AuthHelper
  def require_auth
    @errors = ['Access Denied']
    unless authenticate_token
      render_feedback(@errors, :unauthorized)
    end
  end

  def current_user
    @current_user ||= authenticate_token
  end

  private

  def authenticate_token
    unless user_id_in_token?
      #@errors.push('NO ID')
      return nil
      #render_feedback('Not Authenticated/ID')
    end
    unless valid_token?
      return nil
    end
    begin
      @current_user = User.find(auth_token[:user_id])
    rescue JWT::VerificationError, JWT::DecodeError
      @errors.push('User not found')
      return nil
    end  
  end

  def http_token
      @http_token ||= if request.headers['Authorization'].present?
        request.headers['Authorization'].split(' ').last
      end
  end

  def auth_token
    begin
      @auth_token ||= JsonWebToken.decode(http_token)
    rescue JWT::ExpiredSignature
      @errors.push('Expired Token')
      return false
    end
  end
  def valid_token?
    #Search auth_token in DB/redis
    #Check time validity
    JsonWebToken.valid? @aut_token # && AuthToken(@auth_token).valid? #DB
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id].to_i
  end
end
