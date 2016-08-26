require 'lib'

describe CSVBondFormatter do
  describe '.bond_from(csv_row)' do
    let(:name) { 'G1' }
    let(:type) { 'government' }
    let(:term) { 1.3 }
    let(:bond_yield) { 3.3 }
    let(:csv_row) { [name, type, "#{term} years", "#{bond_yield}%"] }
    subject(:bond) { described_class.bond_from(csv_row) }

    it 'returns a well formed Bond object' do
      expect(bond.name).to eql name
      expect(bond.type).to eql type
      expect(bond.term).to eql term
      expect(bond.yield).to eql bond_yield
    end
  end

  describe '.csv_benchmark_row_from(corporate_bond, government_bond, spread)' do
    subject(:csv_row) { described_class.csv_benchmark_row_from(Bond.new('C1', 'corporate', 123, 789),
                                                                     Bond.new('G1', 'government', 456, 321),
                                                                     2.74) }

    it { should == 'C1,G1,2.74%' }
  end

  describe '.csv_curve_row(corporate_bond, government_bond, spread)' do
    subject(:csv_row) { described_class.csv_curve_row(Bond.new('C1', 'corporate', 123, 789), 2.74) }

    it { should == 'C1,2.74%' }
  end
end
