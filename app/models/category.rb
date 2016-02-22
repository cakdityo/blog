class Category < ActiveRecord::Base
  validates :name, presence: true

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
