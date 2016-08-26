require 'bond'
require 'spread_to_curve'

describe SpreadToCurve do
  let(:government_bonds) { [ Bond.new(9.4, 3.7), Bond.new(12, 4.8), Bond.new(16.3, 5.5) ] }
  subject(:benchmark) { SpreadToCurve.new(government_bonds).for(bond) }

  context 'guideline' do
    let(:expected) { 1.22 }
    let(:bond) { Bond.new(10.3, 5.3) }

    it { should == expected }
  end

  context 'another' do
    let(:expected) { 2.98 }
    let(:bond) { Bond.new(15.2, 8.3) }

    it { should == expected }
  end
end
