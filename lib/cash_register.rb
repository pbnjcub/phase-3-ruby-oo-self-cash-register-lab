require 'pry'

class CashRegister
    attr_accessor :total, :discount, :items, :new_items, :last_item

    def initialize(discount = " ")
        @discount = discount
        @total = 0.to_i
        @new_items = Array.new
        @item_titles = Array.new
        @last_item = Array.new
    end

    def total
        @total
    end

    def add_item(title, price, quantity = 1)
        @last_item = [title, price, quantity]
        if quantity > 1
            for a in 1..quantity do
                @new_items.push([title, price, quantity])
                @item_titles.push(title)
            end
        else
            @new_items.push([title, price, quantity])
            @item_titles.push(title)
        end
        previous_total = @total
        @total = @new_items.reduce(0) {|sum, item| sum + item[1]}
    end

    def void_last_transaction
        @new_items = @new_items.select {|item| item != @last_item}
        @total = @new_items.reduce(0) {|sum, item| sum + item[1]}
    end

    def apply_discount
        if @discount != " "
            @total = @total * (1 - @discount * 0.01)
            "After the discount, the total comes to $#{@total.to_i}."
        else
            "There is no discount to apply."
        end
    end


    def new_items
        @new_items
    end

    def items
        @item_titles
    end

end

cash_register = CashRegister.new
cash_register.add_item("carrots",5,2)
cash_register.add_item("peanuts",2,4)
cash_register.add_item("candy",3)

cash_register_discount = CashRegister.new(10)
cash_register_discount.add_item("carrots",5,2)
cash_register_discount.add_item("peanuts",2,4)
cash_register_discount.add_item("candy",3)


binding.pry

