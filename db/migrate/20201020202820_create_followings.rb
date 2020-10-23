class CreateFollowings < ActiveRecord::Migration[6.0]
  def change
    create_table :followings do |t|
      t.integer :following_id
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
