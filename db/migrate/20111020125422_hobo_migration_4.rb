class HoboMigration4 < ActiveRecord::Migration
  def self.up
	add_column :users,:person_id, :integer
	add_index :users, [:person_id]
    remove_column :notes, :assignment_id

    remove_index :notes, :name => :index_notes_on_assignment_id rescue ActiveRecord::StatementInvalid

    remove_index :assignments, :name => :index_assignments_on_assign_date_and_status rescue ActiveRecord::StatementInvalid
    remove_index :assignments, :name => :index_assignments_on_title rescue ActiveRecord::StatementInvalid
  end

  def self.down
	remove_column :users,:person_id
	
    add_column :notes, :assignment_id, :integer

    add_index :notes, [:assignment_id]

    add_index :assignments, [:assign_date, :status]
    add_index :assignments, [:title]
  end
end
