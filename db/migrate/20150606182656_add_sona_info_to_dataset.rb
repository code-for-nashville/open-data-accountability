class AddSonaInfoToDataset < ActiveRecord::Migration
  def change
    add_column :datasets, :identifier, :text
    add_column :datasets, :category, :text
    add_column :datasets, :title, :text
  end
end
