require_relative '../model/recurso'
require_relative '../model/excepcion_solapamiento_recurso'

# Repositorio de recursos
class RepositorioRecursos
  attr_accessor :recursos

  def initialize
    @recursos = {}
  end
