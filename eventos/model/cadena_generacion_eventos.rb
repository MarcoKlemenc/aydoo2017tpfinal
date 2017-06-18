require_relative '../model/generador_evento_comun'
require_relative '../model/generador_evento_recurrente'

# Clase que administra la Chain of Responsibility para generar eventos
class CadenaGeneracionEventos
  attr_reader :generadores

  def initialize
    @generadores = []
    generador_comun = GeneradorEventoComun.new (nil)
    generador_recurrente = GeneradorEventoRecurrente.new (generador_comun)
    @generadores << generador_recurrente
    @generadores << generador_comun
  end

  def generar_evento(params)
    @generadores.first.generar_evento(params)
  end
  
end
