# Representa un recurso
class Recurso
  attr_reader :nombre
  attr_reader :reservas

  def initialize(nombre)
    @nombre = nombre
    @reservas = []
  end

end
