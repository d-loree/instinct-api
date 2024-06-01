class AddNotNullCOntraintsToUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_null :users, :first_name, false
    change_column_null :users, :last_name, false
    change_column_null :users, :bio, false
    change_column_null :users, :username, false
  end
end
