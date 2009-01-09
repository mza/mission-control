class CreateSpecificationItems < ActiveRecord::Migration
  def self.up
    create_table :specification_items do |t|
      t.string :name
      t.string :capistrano_task
      t.integer :specification_id
      t.timestamps
    end
  end

  def self.down
    drop_table :specification_items
  end
end
