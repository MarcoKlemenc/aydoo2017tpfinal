require_relative '../model/excepcion_nombre_recurso'

NOMBRE_VACIO = ''.freeze

# Representa un recurso
class Recurso
  attr_reader :nombre
  attr_reader :reservas

  def initialize(nombre)
    validar_nombre(nombre)
    @nombre = nombre
    @reservas = []
  end
  
  private

  def validar_nombre(nombre)
    raise ExcepcionNombreRecurso if nombre == NOMBRE_VACIO
  end

end
