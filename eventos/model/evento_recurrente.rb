require_relative '../model/evento'

# Representa un evento. Limitado por un inicio y un fin
# el cual se repite con una determinada frecuencia.
class EventoRecurrente < Evento
  attr_accessor :frecuencia
  attr_accessor :fin_recurrencia

  def to_h
    {
      'id' => @id,
      'nombre' => @nombre,
      'inicio' => @inicio,
      'fin' => @fin,
      'recurrente' => {
        'frecuencia' => @frecuencia,
        'fin' => @fin_recurrencia
      }
    }
  end

  def initialize(id, nombre, inicio, fin, frecuencia, fin_recurrencia, recurso=nil)
    super(id, nombre, inicio, fin, recurso)
    validar_intervalo_recurrencia(inicio, fin_recurrencia)
    @frecuencia = frecuencia
    @fin_recurrencia = fin_recurrencia
    if not recurso.nil?
      reservar_recurrentes(recurso)
    end
  end

  def inicio=(value)
    validar_intervalo_recurrencia(value, @fin_recurrencia)
    super(value)
  end

  def fin_recurrencia=(value)
    validar_intervalo_recurrencia(@inicio, value)
    @fin_recurrencia = value
  end

  def obtener_intervalo
    intervalos = []
    inicio = @inicio
    fin = @fin
    while inicio <= @fin_recurrencia do
      intervalos << (inicio..fin)
      inicio += @frecuencia.frecuencia
      fin += @frecuencia.frecuencia
    end
    intervalos
  end
  
  def eliminar_reservas
    if not @recurso.nil?
      inicio = @inicio
      fin = @fin
      while inicio <= @fin_recurrencia do
        recurso.eliminar_reserva(inicio, fin)
        inicio += @frecuencia.frecuencia
        fin += @frecuencia.frecuencia
      end
    end
  end

  private
                                                
  def reservar_recurrentes(recurso)
    inicio = @inicio + @frecuencia.frecuencia
    fin = @fin + @frecuencia.frecuencia
    while inicio <= @fin_recurrencia do
      recurso.reservar(inicio, fin)
      inicio += @frecuencia.frecuencia
      fin += @frecuencia.frecuencia
    end
  end

  def validar_intervalo_recurrencia(inicio, fin_recurrencia)
    raise ExcepcionIntervaloErroneo if fin_recurrencia < inicio
  end
end
