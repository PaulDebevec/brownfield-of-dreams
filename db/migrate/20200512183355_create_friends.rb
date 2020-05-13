class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :user_friend

      t.timestamps
    end
  end
end
