require_relative '../model/evento_recurrente'
require_relative '../model/generador_evento'

# Clase para generacion de eventos recurrentes mediante Chain of Responsibility
class GeneradorEventoRecurrente < GeneradorEvento
  
  def generar_evento(params)
    if params.key?('recurrencia')
      mapeador = MapeadorFrecuencias.new
      frecuencia_evento = params['recurrencia']['frecuencia']
      frecuencia = mapeador.frecuencias[frecuencia_evento]
      fin_recurrencia_evento = DateTime.parse(params['recurrencia']['fin'])
      evento = EventoRecurrente.new(
        params['id'],
        params['nombre'],
        DateTime.parse(params['inicio']),
        DateTime.parse(params['fin']),
        frecuencia,
        fin_recurrencia_evento
      )
      return evento
    else super(params)
    end
  end
  
end
