class User < ApplicationRecord
  #Chybi ti tu validace. Ja vim, ze uzivatele nemuzu upravit z API, ale validace na modelove vrstve bys mela mit vzdy. (treba kvuli prime manipulaci s objekty v konzoli)
  has_many :todos

  validates :name, presence: true, length: {minimum: 3, maximum: 100}
  validates :email, presence: true
  validates_email_format_of :email
  validates :access_token, presence: true, length: {is: 36}

end
