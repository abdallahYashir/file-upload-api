namespace :files do
  desc "Reset files in storage/files folder"
  task :reset_files => :environment do
    folder_path = Rails.root.join('storage', 'files')

    # Rm rf the folder
    # FileUtils.rm_rf(folder_path)
    Dir.glob("#{folder_path}/*").each do |file|
      File.delete(file) if File.file?(file)
    end
  end
end
