class AddSonaInfoToDataset < ActiveRecord::Migration
  def change
    add_column :datasets, :socrata_owner_id, :text
    add_column :datasets, :socrata_default_page, :text
    add_column :datasets, :socrata_id, :text
    add_column :datasets, :category, :text
    add_column :datasets, :title, :text
  end
end
