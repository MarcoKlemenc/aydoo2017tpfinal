require_relative '../model/recurso'
require_relative '../model/excepcion_unicidad_recurso'
require_relative '../model/excepcion_recurso_inexistente'

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

  def obtener_recurso(identificacion)
    @recursos[identificacion] || raise(ExcepcionRecursoInexistente)
  end

  def eliminar_recurso(identificacion)
    unless @recursos.delete(identificacion)
      raise ExcepcionRecursoInexistente
    end
  end

end
