class User < ApplicationRecord
  #Chybi ti tu validace. Ja vim, ze uzivatele nemuzu upravit z API, ale validace na modelove vrstve bys mela mit vzdy. (treba kvuli prime manipulaci s objekty v konzoli)
  has_many :todos

end
