class AddVendorCountToMarkets < ActiveRecord::Migration[7.0]
  def change
    add_column :markets, :vendor_count, :integer
  end
end
