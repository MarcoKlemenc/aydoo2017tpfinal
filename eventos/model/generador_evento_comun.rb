require_relative '../model/evento'
require_relative '../model/generador_evento'

# Clase para generacion de eventos comunes mediante Chain of Responsibility
class GeneradorEventoComun < GeneradorEvento

  def generar_evento(params)
    if params.key?('id')
      Evento.new(
          params['id'],
          params['nombre'],
          params['inicio'],
          params['fin'],
          params['recurso']
      )
    else
      super(params)
    end
  end
end
