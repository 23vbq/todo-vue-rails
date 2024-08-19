class CreateAttachments < ActiveRecord::Migration[7.2]
  def change
    create_table :attachments do |t|
      t.belongs_to :to_do, null: false, foreign_key: true
      t.string :name
      t.binary :data

      t.timestamps
    end
  end
end
