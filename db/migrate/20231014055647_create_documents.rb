class CreateDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :documents do |t|
      t.string :name
      t.string :path
      t.integer :size
      t.string :extension
      t.string :checksum

      t.timestamps
    end
  end
end
