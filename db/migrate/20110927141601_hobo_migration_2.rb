class HoboMigration2 < ActiveRecord::Migration
  def self.up
    add_column :tickets, :ticket_number, :string
  end

  def self.down
    remove_column :tickets, :ticket_number
  end
end
