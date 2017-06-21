require_relative '../model/excepcion_nombre_recurso'
require_relative '../model/excepcion_solapamiento_recurso'

NOMBRE_VACIO = ''.freeze

# Representa un recurso
class Recurso
  attr_reader :nombre
  attr_reader :reservas

  def to_h
    {
        "nombre" => @nombre
    }
  end

  def initialize(nombre)
    validar_nombre(nombre)
    @nombre = nombre
    @reservas = []
  end

  def reservar(inicio, fin)
    comprobar_solapamiento_recurso(inicio, fin)
    @reservas << (inicio..fin)
  end

  def eliminar_reserva(inicio, fin)
    reservas.delete(inicio..fin)
  end

  private

  def validar_nombre(nombre)
    raise ExcepcionNombreRecurso if nombre == NOMBRE_VACIO
  end

  def comprobar_solapamiento_recurso(inicio, fin)
    intervalos = @reservas.clone
    intervalos.push(inicio..fin)
    intervalos && intervalos.flatten!
    intervalos = intervalos.sort_by {|intervalo| intervalo.min}
    while intervalos.each_cons(2).any? {|a, b|
      min_interseccion = [a.min, b.min].max
      max_interseccion = [a.max, b.max].min
      interseccion = min_interseccion <= max_interseccion
      interseccion && raise(ExcepcionSolapamientoRecurso)
    }
    end
  end

end
