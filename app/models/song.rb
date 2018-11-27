class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :artist_name, presence: true
  validates :released, inclusion: { in: [true, false] }
  validates :title, uniqueness: {
    scope: %i[release_year artist_name],
    message: 'cannot be repeated by the same artist in the same year'
  }
  with_options if: :released? do |song|
  song.validates :release_year, presence: true
  song.validates :release_year, numericality: {
    less_than_or_equal_to: Date.today.year
  }
  end

  def released?
    released
  end

  # validate :release_cant_be_in_future
  #
  # def release_cant_be_in_future
  #   if self.release_year > Date.today.year
  #     errors.add(:release_year, "can't be in the future")
  #   end
  # end
end
