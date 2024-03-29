class CreateDevices < ActiveRecord::Migration[7.0]
  def change
    create_table :devices do |t|
      t.string :name, null: false
      t.string :device_type, null: false
      t.string :os
      t.string :category, null: false
      t.string :tag_no, null: false
      t.string :image_url, null: false
      t.boolean :status, default: false, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
