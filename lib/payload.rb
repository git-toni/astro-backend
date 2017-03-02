module Payload
  def self.build(user,exp)
    HashWithIndifferentAccess.new({
      jit: SecureRandom.hex,
      exp: exp,
      #exp: 1.day.ago.to_i,
      #user_id: user.id,
      user:{
        id: user.id,
        name: user.name,
        email: user.email
      }
    })
  end
end
