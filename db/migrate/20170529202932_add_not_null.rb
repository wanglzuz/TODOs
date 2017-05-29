class AddNotNull < ActiveRecord::Migration[5.1]
  def change

    [:text, :created, :done, :user_id].each do |n|
      change_column_null :todos, n, false
    end
    [:name, :email, :access_token].each do |n|
      change_column_null :users, n, false
    end

  end
end
