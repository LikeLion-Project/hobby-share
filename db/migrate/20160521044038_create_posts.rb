class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :receiver_id
      t.string :title, default: ""
      t.string :content, default: ""
      t.timestamps null: false
    end
  end
end
