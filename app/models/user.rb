class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts
  has_many :comments
  
  has_many :likes
  has_many :receivers, :through => :likes,
                       class_name: "User",
                       foreign_key: "user_id"
end