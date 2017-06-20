# Error para cuando se solapan los intervalos
# de tiempo entre recursos de un evento
class ExcepcionSolapamientoRecurso < StandardError
  def initialize(msg = 'No se pueden solapar recursos en un mismo evento.')
    super
  end
end
