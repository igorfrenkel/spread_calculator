class Bond
  attr_accessor :term, :yield

  def initialize(term, bond_yield)
    @term = term
    @yield = bond_yield
  end

  def <=>(other_bond)
    @term <=> other_bond.term
  end

  def ==(other_bond)
    @term == other_bond.term && @yield == other_bond.yield
  end
end
