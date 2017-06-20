# Error para cuando una accion solicita un recurso inexistente
class ExcepcionRecursoInexistente < StandardError
  def initialize(msg = 'Recurso Inexistente')
    super
  end
end
