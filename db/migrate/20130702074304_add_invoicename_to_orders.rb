class AddInvoicenameToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :invoicename, :string
  end
end
