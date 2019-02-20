class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    vendors.collect do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    vendors.select do |vendor|
      vendor.check_stock(item) != 0
    end
  end

  def sorted_item_list
    items = []
    vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        items << item
      end
    end
    items.uniq.sort
  end

  def total_inventory
    total_inventory = Hash.new {|hash, key| hash[key] = 0}
    vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        total_inventory[item] += quantity
      end
    end
    total_inventory
  end

  def sell(item, quantity)
    if total_inventory[item] < quantity
      false
    else
      vendors.each do |vendor|
        if vendor.inventory[item] >= quantity
          vendor.inventory[item] -= quantity
        elsif (vendor.inventory[item] != 0) && (vendor.inventory[item] < quantity)
          quantity -= vendor.inventory[item]
          vendor.inventory[item] = 0
        end
      end
    end
  end

end
