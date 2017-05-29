class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    # Chybi ti zde to, ze zadne z tech policek nemuze byt null. zprav to v dalsi migraci
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :access_token

      t.timestamps
    end
  end
end
