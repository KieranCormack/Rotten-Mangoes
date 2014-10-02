class Movie < ActiveRecord::Base

  has_many :reviews

  mount_uploader :image, ImageUploader

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true },
    length: { maximum: 999 }

  validates :description,
    presence: true

  validates :image,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_future

  def review_average
    if reviews.size == 0
      return "0"
    else
      reviews.sum(:rating_out_of_ten) / reviews.size
    end
  end

# Search functions for title, director, and duration

  scope :by_title_director, ->(search) { where('UPPER(title) LIKE UPPER(?) OR UPPER(director) LIKE UPPER(?)',"%#{search}%","%#{search}%") if search }
  # scope :by_director, ->(director) { where('UPPER(director) LIKE UPPER(?)',"%#{director}%") if director }
  scope :by_duration, ->(limit1,limit2) { where('runtime_in_minutes BETWEEN ? AND ?', limit1, limit2) if limit1 && limit2}

    def self.search(search, duration)
      
      case duration
      when 'Under 90 minutes'
        limit = [0,90]
      when 'between 90 and 120 minutes'
        limit = [90,120]
      when 'over 120 minutes'
        limit = [120,999]
      else
        limit = [0,999]
      end

      by_title_director(search).by_duration(limit[0], limit[1])
    
    end
  
# protected methods

  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end



end
