class ChangeDataTypeForCreationAndPlanningDate < ActiveRecord::Migration[7.2]
  def self.up
    change_table :to_dos do |t|
      t.change :date_creation, :datetime
      t.change :date_planning, :datetime
    end
  end
  def self.down
    change_table :to_dos do |t|
      t.change :date_creation, :date
      t.change :date_planning, :date
    end
  end
end
