class Addindex < ActiveRecord::Migration
  def self.up
	add_index :assignments, [:assign_date,:status]
    add_index :assignments, :title
  end

  def self.down
	remove_index :assignments, [:assign_date,:status]
    remove_index :assignments, :title
  end
end
