require 'bond'
require 'benchmark'

# tradeoff: object oriented rather than functional (for descriptiveness)
# tradeoff: initialize with government bonds for ease of use, rather than streaming bonds
describe SpreadToBenchmark do
  describe '.candidate_government_bond' do
    let(:bond1) { Bond.new(9.4, 3.7) }
    let(:bond2) { Bond.new(12, 4.8) }
    let(:government_bonds) { [ bond1, bond2 ] }
    subject(:benchmark) { SpreadToBenchmark.new(government_bonds).candidate_government_bond_for(bond) }

    context 'guideline' do
      let(:expected) { bond1 }
      let(:bond) { Bond.new(10.3, 5.3) }

      it { should == expected }
    end
  end

  describe '#for(bond)' do
    let(:government_bonds) { [ Bond.new(9.4, 3.7), Bond.new(12, 4.8) ] }
    subject(:benchmark) { SpreadToBenchmark.new(government_bonds).for(bond) }

    context 'guideline' do
      let(:expected) { 1.60 }
      let(:bond) { Bond.new(10.3, 5.3) }

      it { should == expected }
    end

    context 'another' do
      let(:expected) { 2.7 }
      let(:bond) { Bond.new(14, 7.5) }

      it { should == expected }
    end
  end
end
