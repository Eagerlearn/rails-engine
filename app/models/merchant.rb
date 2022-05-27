class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices
  has_many :invoice_items, through: :invoices

  def self.top_merchants_most_items_sold(quantity)
    .joins(invoices: :invoice_items)
    .select('merchants.*, SUM(invoice_items.quantity) as count')
    .group(:id)
    .order(count: :desc)
    .limit(quantity)
  end
end
