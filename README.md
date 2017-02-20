## JWT notes

JWT decoding checks the expiration field.
```ruby
plo = { user_id: 1 }
ploexp = { user_id:1, exp: 1.day.ago.to_i } # Expired 'exp'
algo = 'HS256'
secret='123123'

encoded_ok = JWT.encode(plo, secret, algo)
encoded_exp = JWT.encode(ploexp, secret, algo)

JWT.decode(encoded_ok,secret,true,{algorithm: algo}) # <-- Ok, no prob
JWT.decode(encoded_ext,secret,true,{algorithm: algo})
# raises -> JWT::ExpiredSignature: Signature has expired
```
