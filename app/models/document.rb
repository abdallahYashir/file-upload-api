class Document < ApplicationRecord
  validate :name, presence: true
  validate :path, presence: true
  validate :size, presence: true
  validate :extension, presence: true
  validate :checksum, unique: true

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
