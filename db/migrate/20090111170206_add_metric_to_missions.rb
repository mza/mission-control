class AddMetricToMissions < ActiveRecord::Migration
  def self.up
    add_column :missions, :metric, :string
  end

  def self.down
    remove_column :missions, :metric
  end
end
