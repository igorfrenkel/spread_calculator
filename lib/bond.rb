class Bond
  attr_accessor :name, :type, :term, :yield

  def initialize(name, type, term, bond_yield)
    @name = name
    @type = type
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
