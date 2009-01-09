class AddInstance < ActiveRecord::Migration
  def self.up
    create_table :instances do |t|
      t.string :name
      t.string :mission_id
      t.string :specification_id
      t.timestamps
    end
  end

  def self.down
    drop_table :missions
  end
end
