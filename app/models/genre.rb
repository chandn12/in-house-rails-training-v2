class Genre < ApplicationRecord
  include Discard::Model

  has_and_belongs_to_many :books
end
