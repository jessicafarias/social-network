class AddFollowedIdToFollowing < ActiveRecord::Migration[6.0]
  def change
    add_reference :followings, :user, foreign_key: true
    add_column :followings, :following_id, :integer
  end
end
