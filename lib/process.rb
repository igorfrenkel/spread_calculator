$:.unshift File.join(File.dirname(__FILE__))
require 'csv'
require 'lib'

class SpreadCalculationProcessor
  def initialize(csv_file)
    @government_bonds = []
    @corporate_bonds = []
    CSV.read(csv_file).each_with_index do |row,idx|
      next if idx == 0
      bond = CSVBondFormatter.bond_from(row)
      case bond.type
      when 'corporate'
        @corporate_bonds << bond
      when 'government'
        @government_bonds << bond
      else
        raise ArgumentError, 'invalid bond type supplied'
      end
    end
  end

  def process
    spread_to_benchmark = SpreadToBenchmark.new(@government_bonds)
    spread_to_curve = SpreadToCurve.new(@government_bonds)
    benchmark_csv = ['bond,benchmark,spread_to_benchmark']
    curve_csv = ['bond,spread_to_curve']
    @corporate_bonds.each do |bond|
      benchmark = spread_to_benchmark.for(bond)
      benchmark_csv << CSVBondFormatter.csv_benchmark_row_from(bond, benchmark.first, benchmark.last)
      curve_csv << CSVBondFormatter.csv_curve_row(bond, spread_to_curve.for(bond))
    end

    puts 'Writing ./spread_to_benchmark.csv'
    File.open('./spread_to_benchmark.csv', 'wb') { |f| f.write(benchmark_csv.join("\n")) }
    puts 'Writing ./spread_to_curve.csv'
    File.open('./spread_to_curve.csv', 'wb') { |f| f.write(curve_csv.join("\n")) }
  end
end

raise ArgumentError, 'You must supply a properly formatted csv file (see README.md)' if ARGV.count != 1

SpreadCalculationProcessor.new(ARGV[0])
  .process
