class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :message
      t.integer :from_id
      t.integer :to_id

      t.timestamps
    end
  end
end
