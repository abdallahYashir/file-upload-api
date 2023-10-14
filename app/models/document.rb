class Document < ApplicationRecord
  validates :name, presence: true
  validates :path, presence: true
  validates :size, presence: true
  validates :extension, presence: true
  validates :checksum, uniqueness: true

  scope :by_name, -> { order(name: :asc) }
  scope :checksum, -> { where(checksum: checksum) }

  def initialize(file)
    super()

    self.name = file.original_filename
    self.path = save_file!(file)
    self.size = File.size(self.path)
    self.extension = File.extname(self.path)
    self.checksum = get_checksum(self.path)
  end

  def serializable_hash(options = nil)
    super(options).except("path")
  end

  def save_file!(file)
    return if file.nil?

    begin
      unique_filename = unique_filename(file.original_filename)

      path = Rails.root.join('storage', 'files', unique_filename)
      File.open(path, 'wb') { |f| f.write(file.read) }
      path
    rescue StandardError => e
      # Handle the exception, log it, or re-raise it as needed
      Rails.logger.error("Error saving file: #{e.message}")
      raise e
    end
  end

  def get_checksum(path)
    Digest::SHA256.hexdigest(File.read(path))
  end

  private

  def unique_filename(filename)
    timestamp = Time.now.strftime('%Y%m%d%H%M%S')
    "#{timestamp}_#{filename}"
  end

end
