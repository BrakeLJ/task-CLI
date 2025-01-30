require 'csv'

class CSVParser
  FILE_NAME = 'products.csv'

  def initialize 
    @products = []
  end

  def parse_csv 
    # load the file and read each row adding it as a hash to the products array

    CSV.foreach(FILE_NAME, headers: true) do | row |
      @products << {
        name: row["name"],
        price: row["price"].to_f,
        quantity: row["quantity"].to_i
    }.transform_keys(&:to_sym)
    end
  end

  def products_value
    # display each product and total value in inventory by multiplying the value by the quantity
    # display a total value for all inventory in stock
  end

  def run 
    # run the parse_csv and products_value methods
    parse_csv
  end
end