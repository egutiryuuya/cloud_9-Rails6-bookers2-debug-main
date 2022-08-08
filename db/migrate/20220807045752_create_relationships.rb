class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      # フォローしたユーザー
      t.integer :follower_id, null: false
      
      # フォローされたユーザー
      t.integer :following_id, null: false

      t.timestamps
    end
  end
end
