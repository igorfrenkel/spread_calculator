require 'csv'
require 'lib'

csv_file = ARGV[0]

government_bonds = []
corporate_bonds = []
CSV.read(csv_file).each_with_index do |row,idx|
  next if idx == 0
  bond = CSVBondFormatter.bond_from(row)
  case bond.type
  when 'corporate'
    corporate_bonds << bond
  when 'government'
    government_bonds << bond
  else
    raise ArgumentError, 'invalid bond type supplied'
  end
end
puts government_bonds
puts corporate_bonds

