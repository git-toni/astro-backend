class FullTelescopeSerializer < TelescopeSerializer
  has_many :posts, each_serializer:PostSerializer
end
