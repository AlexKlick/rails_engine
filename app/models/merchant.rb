class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  def self.get_merchants_revenue_desc(params)
    joins(items: [{invoice_items: {invoice: :transactions }}])
      .where("transactions.result = ?", "success")
      .where("invoices.status = ?", "shipped")
      .group("merchants.id")
      .select('SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue, merchants.*')
      .order("revenue DESC")
      .limit(params[:quantity])
  end
  def self.get_merchant_revenue(id)
    joins(items: [{invoice_items: {invoice: :transactions }}])
    .where("transactions.result = ?", "success")
    .where("invoices.status = ?", "shipped")
    .group("merchants.id")
    .where("merchants.id = ?", id)
    .select('SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue, merchants.*')[0]
  end
  def self.get_merchants_most_items_sold(params)
    joins(items: [{invoice_items: {invoice: :transactions }}])
    .where("transactions.result = ?", "success")
    .where("invoices.status = ?", "shipped")
    .group("merchants.id")
    .select('SUM(invoice_items.quantity) AS count, merchants.*')
    .order("count DESC")
    .limit(params[:quantity].to_i)
  end
end
