class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :gender, :string
    add_column :users, :category, :string
    add_column :users, :major, :string
    add_column :users, :pic, :string
    add_column :users, :introduce, :text
    add_column :users, :like_count, :integer
  end
end
