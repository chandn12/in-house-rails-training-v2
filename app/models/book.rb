class Book < ApplicationRecord
  include Discard::Model
  include PublicActivity::Model
  tracked owner: Proc.new { |controller, model| controller&.current_user }

  has_many :activities, as: :trackable, class_name: "PublicActivity::Activity", dependent: :destroy

  has_many :likes, dependent: :destroy

  belongs_to :user, optional: true
  has_and_belongs_to_many :genres

  has_one_attached :cover

  validate :cover_format
  validates :name, :short_description, presence: true

  scope :recent_first, -> { order(created_at: :desc) }

  delegate :can?, :cannot?, to: :ability

  after_create :notify_admin_of_new_book

  def to_s
    name
  end

  def discardable?
    return false if discarded?
    true
  end

  def liked?(user)
    !!self.likes.find { |like| like.user_id == user.id }
  end

  def ability
    @ability ||= Ability.new(self)
  end

  def cover_format
    return unless cover.attached?

    unless cover.content_type.in?(%w[image/png image/jpeg])
      errors.add(:cover, "must be a PNG or JPG")
    end
  end

  private

  def notify_admin_of_new_book
    AdminMailer.new_book(self).deliver_now
  end
end
