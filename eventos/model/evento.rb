require_relative '../model/regla_intervalo_evento'
require_relative '../model/excepcion_intervalo_erroneo'

CONVERSOR_HORAS = (1 / 24.0)

# Representa un evento. Limitado por un inicio y un fin
class Evento
  attr_reader :id
  attr_accessor :nombre, :inicio, :fin, :recurso

  def to_h
    hash = {
        'id' => @id,
        'nombre' => @nombre,
        'inicio' => @inicio,
        'fin' => @fin
    }
    if @recurso
      hash['recurso'] = @recurso.nombre
    end
    hash
  end

  def initialize(id, nombre, inicio, fin, recurso=nil)
    validar_intervalo(inicio, fin)
    @id = id
    @nombre = nombre
    @inicio = inicio
    @fin = fin
    if recurso
      recurso.reservar(@inicio, @fin)
      @recurso = recurso
    end
  end

  def inicio=(value)
    validar_intervalo(value, @fin)
    @inicio = value
  end

  def fin=(value)
    validar_intervalo(@inicio, value)
    @fin = value
  end

  def obtener_intervalo
    @inicio..@fin
  end

  def eliminar_reservas
    if @recurso
      @recurso.eliminar_reserva(@inicio, @fin)
    end
  end

  private

  def validar_intervalo(inicio, fin)
    raise ExcepcionIntervaloErroneo if fin < inicio
    intervalo_en_horas = convertir_a_horas(fin - inicio)
    ReglaIntervaloEvento.validar_horas(intervalo_en_horas)
  end

  def convertir_a_horas(intervalo)
    intervalo / CONVERSOR_HORAS
  end
end
