class PostSerializer < ActiveModel::Serializer
  attributes :id, :image_url, :description, :telescope_id
end
