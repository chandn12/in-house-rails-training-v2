class Book < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :genres

  has_one_attached :cover

  validate :cover_format
  validates :name, :short_description, presence: true

  scope :recent_first, -> { order(created_at: :desc) }

  delegate :can?, :cannot?, to: :ability

  def ability
    @ability ||= Ability.new(self)
  end

  def cover_format
    return unless cover.attached?

    unless cover.content_type.in?(%w[image/png image/jpeg])
      errors.add(:cover, "must be a PNG or JPG")
    end
  end
end
