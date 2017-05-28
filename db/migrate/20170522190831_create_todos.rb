class CreateTodos < ActiveRecord::Migration[5.1]
  def change
    # Chybi ti zde to, ze zadne z tech policek nemuze byt null/nil (nedavalo by to businessove smysl, aby jakekoli z nich mohlo byt null/nil). zprav to v dalsi migraci
    create_table :todos do |t|
      t.string :text
      t.datetime :created
      t.boolean :done
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
