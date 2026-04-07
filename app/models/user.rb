class User < ApplicationRecord
  include Discard::Model
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books

  include PublicActivity::Model
  tracked only: [ :create, :destroy ], owner: :itself

  after_create :notify_admin_of_new_user

  def to_s
    "New User: #{self.first_name}"
  end

  def admin?
    admin
  end

  private

  def notify_admin_of_new_user
    AdminMailer.new_user(self).deliver_now
  end
end
