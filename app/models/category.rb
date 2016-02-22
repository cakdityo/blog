class Category < ActiveRecord::Base

  has_many :article_categories
  has_many :articles, through: :article_categories

  validates :name, presence: true

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
