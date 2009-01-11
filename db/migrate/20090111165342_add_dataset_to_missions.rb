class AddDatasetToMissions < ActiveRecord::Migration
  def self.up
    add_column :missions, :dataset, :string
  end

  def self.down
    remove_column :missions, :dataset
  end
end
