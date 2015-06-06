class CreateDatasets < ActiveRecord::Migration
  def change
    create_table :datasets do |t|
      t.datetime :date_updated
      t.integer :expected_frequency_of_update
      t.datetime :date_created

      t.timestamps null: false
    end
  end
end
