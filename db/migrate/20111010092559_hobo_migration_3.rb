class HoboMigration3 < ActiveRecord::Migration
  def self.up
    add_column :knowledges, :title, :string
    add_column :knowledges, :create_date, :date
    add_column :knowledges, :symptom, :text
    add_column :knowledges, :cause, :text
    add_column :knowledges, :resolution, :text
    add_column :knowledges, :KB_type, :string
    add_column :knowledges, :product, :string
    add_column :knowledges, :person_id, :integer
    add_column :knowledges, :ticket_id, :integer

    add_column :assignments, :ticket_type, :string

    add_index :knowledges, [:person_id]
    add_index :knowledges, [:ticket_id]
  end

  def self.down
    remove_column :knowledges, :title
    remove_column :knowledges, :create_date
    remove_column :knowledges, :symptom
    remove_column :knowledges, :cause
    remove_column :knowledges, :resolution
    remove_column :knowledges, :KB_type
    remove_column :knowledges, :product
    remove_column :knowledges, :person_id
    remove_column :knowledges, :ticket_id

    remove_column :assignments, :ticket_type

    remove_index :knowledges, :name => :index_knowledges_on_person_id rescue ActiveRecord::StatementInvalid
    remove_index :knowledges, :name => :index_knowledges_on_ticket_id rescue ActiveRecord::StatementInvalid
  end
end
