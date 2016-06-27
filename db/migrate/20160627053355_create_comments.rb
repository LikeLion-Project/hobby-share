class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|

      t.timestamps null: false
      t.integer :user_id
      t.integer :receiver_id
      t.text :content
    end
  end
end
