# Clase base para generacion de eventos mediante Chain of Responsibility
class GeneradorEvento
  attr_reader :siguiente

  def initialize(siguiente)
    @siguiente = siguiente
  end

  def generar_evento(params)
    if siguiente.nil?
      nil
    else
      siguiente.generar_evento(params)
    end
  end

end
