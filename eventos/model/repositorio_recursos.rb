require_relative '../model/recurso'
require_relative '../model/excepcion_unicidad_recurso'

# Repositorio de recursos
class RepositorioRecursos
  attr_accessor :recursos

  def initialize
    @recursos = {}
  end

  def almacenar_recurso(recurso)
    identificacion = recurso.nombre
    comprobar_unicidad_recurso(identificacion)
    @recursos[identificacion] = recurso
  end
  
  def comprobar_unicidad_recurso(identificacion)
    raise ExcepcionUnicidadRecurso if @recursos.key?(identificacion)
  end
  
end
