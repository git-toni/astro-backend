require 'jwt'

class JsonWebToken
  ALGORITHM = 'HS256'

  def self.issue(payload)
    JWT.encode(
      payload,
      auth_secret,
      ALGORITHM)
  end

  def self.decode(token)
    #binding.pry
    HashWithIndifferentAccess.new(
      JWT.decode(token, 
        auth_secret, 
        true, 
        { algorithm: ALGORITHM }).first
    )
  end
  def self.valid?(token)
    return true
  end

  def self.auth_secret
    ENV["AUTH_SECRET"]
  end

end
