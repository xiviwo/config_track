class HoboMigration1 < ActiveRecord::Migration
  def self.up
    add_column :notes, :title, :string
    add_column :notes, :create_date, :date
    add_column :notes, :summary, :text
    add_column :notes, :assignment_id, :integer

    add_column :assignments, :title, :string
    add_column :assignments, :assign_date, :date
    add_column :assignments, :close_date, :date
    add_column :assignments, :status, :string
    add_column :assignments, :link, :string
    add_column :assignments, :person_id, :integer

    add_column :tickets, :title, :string
    add_column :tickets, :create_date, :date
    add_column :tickets, :close_date, :date
    add_column :tickets, :status, :string
    add_column :tickets, :summary, :text
    add_column :tickets, :assignment_id, :integer

    add_column :people, :name, :string
    add_column :people, :serial_number, :string

    add_index :notes, [:assignment_id]

    add_index :assignments, [:person_id]

    add_index :tickets, [:assignment_id]
  end

  def self.down
    remove_column :notes, :title
    remove_column :notes, :create_date
    remove_column :notes, :summary
    remove_column :notes, :assignment_id

    remove_column :assignments, :title
    remove_column :assignments, :assign_date
    remove_column :assignments, :close_date
    remove_column :assignments, :status
    remove_column :assignments, :link
    remove_column :assignments, :person_id

    remove_column :tickets, :title
    remove_column :tickets, :create_date
    remove_column :tickets, :close_date
    remove_column :tickets, :status
    remove_column :tickets, :summary
    remove_column :tickets, :assignment_id

    remove_column :people, :name
    remove_column :people, :serial_number

    remove_index :notes, :name => :index_notes_on_assignment_id rescue ActiveRecord::StatementInvalid

    remove_index :assignments, :name => :index_assignments_on_person_id rescue ActiveRecord::StatementInvalid

    remove_index :tickets, :name => :index_tickets_on_assignment_id rescue ActiveRecord::StatementInvalid
  end
end
