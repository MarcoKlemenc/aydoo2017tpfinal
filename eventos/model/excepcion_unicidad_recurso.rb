# Error para violacion de unicidad de recursos segun su nombre
class ExcepcionUnicidadRecurso < StandardError
  def initialize(msg = 'Ya existe un recurso con ese nombre.')
    super
  end
end
