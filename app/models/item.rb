class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items

  def self.get_revenue_desc(quantity)
    joins(invoice_items: {invoice: :transactions})
    .where("transactions.result = ?", "success")
    .where("invoices.status = ?", "shipped")
    .select('SUM(invoice_items.quantity * invoice_items.unit_price) as revenue, items.*')
    .group('items.id')
    .order('revenue desc')
    .limit(quantity == nil ? 10 : quantity)
  end
end
