#Jedna classa per file. vzdy. Pokud to tak nebudes delat, budes mit velke mrzeni s Rails Class Autoladerem (to co zajistuje, ze nikam normalne nemusis psat require a ze to co ulozis se v devu rovnou prenacte).
class TodoInfoSerializer < ActiveModel::Serializer
  attributes :id, :text, :done
end

class TodoSerializer < TodoInfoSerializer
  attributes :created
end
