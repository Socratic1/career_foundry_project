class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders
  has_many :comments
  has_many :wishes
  
  def follow!(user)
    $redis.multi do 
      $redis.sadd("user_#{self.id}_following", user.id)
      $redis.sadd("user_#{user.id}_followers", self.id)
    end
  end

  def unfollow!(user)
    $redis.multi do
      $redis.srem("user_#{self.id}_following", user.id)
      $redis.srem("user_#{user.id}_followers", self.id)
    end
  end

  def followers
  	user_ids = $redis.smembers("user_#{self.id}_followers")
  	User.where(:id => user_ids)
  end

  def following
  	user_ids = $redis.smembers("user_#{self.id}_following")
  	User.where(:id => user_ids)
  end

end
