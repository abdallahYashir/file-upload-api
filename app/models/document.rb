class Document < ApplicationRecord
  attr_reader :name, :path, :size, :extension, :checksum
  validates :name, presence: true
  validates :path, presence: true
  validates :size, presence: true
  validates :extension, presence: true
  validates :checksum, uniqueness: true

  scope :by_name, -> { order(name: :asc) }
  scope :checksum, -> { where(checksum: checksum) }

  def initialize(file)
    super()

    @name = file.original_filename
    @path = save_file!(file)
    @size = File.size(@path)
    @extension = File.extname(@path)
    @checksum = get_checksum(@path)
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
