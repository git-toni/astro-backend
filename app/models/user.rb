class User < ApplicationRecord
  has_secure_password
  validates_presence_of :name, :email
  validates_presence_of :password, on: :create
  before_validation(on: :create) do
    generate_token(:auth_token)
  end


  private
  def generate_token(column)
    begin
      self[column]=SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
