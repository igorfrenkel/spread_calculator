require 'bond'
require 'benchmark'
require 'pry'

class SpreadToCurve < SpreadToBenchmark

  # edgecase: at the edges of the curve, need to extrapolate
  def for(corporate_bond)
    candidate_bond = candidate_government_bond_for(corporate_bond)
    index = @government_bonds.find_index(candidate_bond)
    if index < @government_bonds.count-1
      neighbouring_bond = @government_bonds[index+1]
      yield_on_curve = candidate_bond.yield + (corporate_bond.term-candidate_bond.term)*((neighbouring_bond.yield-candidate_bond.yield)/(neighbouring_bond.term-candidate_bond.term))
    else
      neighbouring_bond = @government_bonds[index-1]
      yield_on_curve = neighbouring_bond.yield + ((corporate_bond.term-neighbouring_bond.term)/(candidate_bond.term-neighbouring_bond.term))*(candidate_bond.yield-neighbouring_bond.yield)
    end

    (corporate_bond.yield-yield_on_curve).abs.round(2)
  end
end
