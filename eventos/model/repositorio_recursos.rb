require_relative '../model/recurso'
require_relative '../model/excepcion_solapamiento_recurso'

# Repositorio de recursos
class RepositorioRecursos
  attr_accessor :recursos

  def initialize
    @recursos = {}
  end

  def almacenar_recurso(recurso)
    identificacion = recurso.nombre
    comprobar_unicidad_recurso(recurso)
    @recursos[identificacion] = recurso
  end
