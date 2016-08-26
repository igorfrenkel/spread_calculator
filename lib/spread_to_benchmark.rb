require 'bond'

class SpreadToBenchmark
  #
  # Assumption: government bonds are not sorted
  def initialize(government_bonds)
    @government_bonds = government_bonds.sort
  end

  def candidate_government_bond_for(corporate_bond)
    candidate_bond=nil
    candidate_spread=100000
    @government_bonds.each do |government_bond|
      current_spread=(government_bond.term-corporate_bond.term).abs
      if current_spread < candidate_spread
        candidate_spread = current_spread
        candidate_bond = government_bond
      end
    end
    candidate_bond
  end

  def for(corporate_bond)
    candidate_bond = candidate_government_bond_for(corporate_bond)
    [candidate_bond, (corporate_bond.yield - candidate_bond.yield).abs.round(2)]
  end
end
