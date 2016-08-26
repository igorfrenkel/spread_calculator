class CSVBondFormatter

  # Given a csv row, output a Bond object
  def self.bond_from(csv_row)
    name = csv_row[0]
    type = csv_row[1]
    year = csv_row[2].split(' ')[0].to_f
    bond_yield = csv_row[3][0..-2].to_f
    Bond.new(name, type, year, bond_yield)
  end

  # Given a Bond object, output a spread to benchmark yield row
  def self.csv_benchmark_row_from(corporate_bond, government_bond, spread)
    "#{corporate_bond.name},#{government_bond.name},#{spread}%"
  end

  # Given a Bond object, output a spread to curve yield row
  def self.csv_curve_row(corporate_bond, spread)
    "#{corporate_bond.name},#{spread}%"
  end
end
