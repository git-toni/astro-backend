class TelescopeSerializer < ActiveModel::Serializer
  attributes  :name, :regime, :operator, :cospar_id
end

