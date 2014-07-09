class CreateKnowledges < ActiveRecord::Migration
  def self.up
    create_table :knowledges do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :knowledges
  end
end
