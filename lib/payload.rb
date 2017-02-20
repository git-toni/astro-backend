module Payload
  def self.build(user,exp)
    HashWithIndifferentAccess.new({
      jit: SecureRandom.hex,
      exp: exp,
      #exp: 1.day.ago.to_i,
      user_id: user.id
    })
  end
end
