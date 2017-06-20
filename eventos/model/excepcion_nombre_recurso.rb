# Error para nombres invalidos en recurso
class ExcepcionNombreRecurso < StandardError
  def initialize(msg = 'No se puede crear un recurso sin nombre')
    super
  end
end
