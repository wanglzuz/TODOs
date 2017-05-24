class TodoInfoSerializer < ActiveModel::Serializer
  attributes :id, :text, :done
end

class TodoSerializer < TodoInfoSerializer
  attributes :created
end
