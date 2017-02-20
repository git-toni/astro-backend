require "bcrypt"

module GeneralHelper
  def default_password_digest
    BCrypt::Password.create(default_password, cost: 4)
  end

  def default_password
    "123123"
  end
  def get_auth(url,token)
    get url, headers:{ "Authorization" => "Bearer #{token}" }
  end
end
