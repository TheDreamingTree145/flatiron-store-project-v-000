class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, :through => :line_items
  belongs_to :user

  def total
    total = 0
    line_items.each do |line_item|
      total = total + (line_item.item.price * line_item.quantity)
    end
    total
  end

  def add_item(id)
    line_item = self.line_items.find_by(item_id: id)
    if line_item
      line_item.quantity += 1
      line_item.save
    else
      line_item = self.line_items.build(item_id: id)
      self.items << Item.find(id)
    end
    line_item
  end

  def self.checkout(user)
    user.current_cart.line_items.each do |line_item|
      line_item.item.inventory -= line_item.quantity
      line_item.item.save
    end
    user.current_cart.destroy
  end


end
