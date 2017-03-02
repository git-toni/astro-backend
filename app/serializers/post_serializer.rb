class PostSerializer < ActiveModel::Serializer
  attributes  :image_url, :description
  belongs_to :telescope, serializer: TelescopeSerializer
end
