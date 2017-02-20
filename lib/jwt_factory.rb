class JwtFactory
  def self.create(user, exp=4.hours.from_now.to_i)
    payload = Payload.build(user,exp)
    jwt = JsonWebToken.issue(payload)
    keypath = "auth_tokens:#{payload['user_id']}:#{payload['jit']}"
    $redis.hset(keypath,'timestamp',Time.now.to_i)
    $redis.expireat(keypath,payload['exp'])
    jwt
  end
end
