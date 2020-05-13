class AddLoginToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :login, :string, :default => "No Login"
  end
end
