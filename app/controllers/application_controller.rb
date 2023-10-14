class ApplicationController < ActionController::API
end

# TODO: create a new controller / API for Files
# Model: File
# generate model File with the following attributes:
# - name string
# - path string
# - size integer
# - extension or type string
# - checksum string

# File methods
# - save_file -> save file to disk -> path + file_name
# - verify_checksum
# File Attributes
# - file_name -> path + name + extension
# - path -> storage/files/

# which gem to use for File Handling?
# active_storage? paperclip? shrine? carrierwave?

