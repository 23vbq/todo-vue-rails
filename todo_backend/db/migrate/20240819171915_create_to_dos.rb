class CreateToDos < ActiveRecord::Migration[7.2]
  def change
    create_table :to_dos do |t|
      t.integer :status
      t.belongs_to :group, null: false, foreign_key: true
      t.integer :priority
      t.date :date_creation
      t.date :date_planning
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
