class CreateSpecifications < ActiveRecord::Migration
  def self.up
    create_table :specifications do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :specifications
  end
end
