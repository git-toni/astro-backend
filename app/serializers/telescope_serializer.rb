class TelescopeSerializer < ActiveModel::Serializer
  attributes :id, :name, :regime, :operator, :cospar_id
end
