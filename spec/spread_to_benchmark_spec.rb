require 'lib'

# tradeoff: object oriented rather than functional (for descriptiveness)
# tradeoff: initialize with government bonds for ease of use, rather than streaming bonds
describe SpreadToBenchmark do
  describe '.candidate_government_bond' do
    let(:bond1) { Bond.new('G1', 'government', 9.4, 3.7) }
    let(:bond2) { Bond.new('G2', 'government', 12, 4.8) }
    let(:government_bonds) { [ bond1, bond2 ] }
    subject(:benchmark) { SpreadToBenchmark.new(government_bonds).candidate_government_bond_for(corporate_bond) }

    context 'guideline' do
      let(:expected) { bond1 }
      let(:corporate_bond) { Bond.new('C1', 'corporate', 10.3, 5.3) }

      it { should == expected }
    end
  end

  describe '#for(bond)' do
    let(:bond1) { Bond.new('G1', 'government', 9.4, 3.7) }
    let(:bond2) { Bond.new('G2', 'government', 12, 4.8) }

    let(:government_bonds) { [ bond1, bond2 ] }
    subject(:benchmark) { SpreadToBenchmark.new(government_bonds).for(corporate_bond) }

    context 'guideline' do
      let(:expected) { [bond1, 1.60] }
      let(:corporate_bond) { Bond.new('C1', 'corporate', 10.3, 5.3) }

      it { should == expected }
    end

    context 'another' do
      let(:expected) { [bond2, 2.7] }
      let(:corporate_bond) { Bond.new('C1', 'corporate', 14, 7.5) }

      it { should == expected }
    end
  end
end
