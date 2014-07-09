class HoboMigration5 < ActiveRecord::Migration
  def self.up
    add_column :tickets, :customer, :string
    add_column :tickets, :email, :string

    remove_index :assignments, :name => :index_assignments_on_assign_date_and_status rescue ActiveRecord::StatementInvalid
    remove_index :assignments, :name => :index_assignments_on_title rescue ActiveRecord::StatementInvalid
  end

  def self.down
    remove_column :tickets, :customer
    remove_column :tickets, :email

    add_index :assignments, [:assign_date, :status]
    add_index :assignments, [:title]
  end
end
