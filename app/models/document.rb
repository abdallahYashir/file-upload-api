class Document < ApplicationRecord
  validates :name, presence: true
  validates :path, presence: true
  validates :size, presence: true
  validates :extension, presence: true
  validates :checksum, uniqueness: true

  before_create :get_checksum

  scope :by_name, -> { order(name: :asc) }
  scope :checksum, -> { where(checksum: checksum) }

  def save_file
  end

  def get_checksum

  end

  def get_file_name
  end

  def get_file
  end

  def get_file_path
  end

end
