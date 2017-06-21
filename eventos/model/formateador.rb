require 'json'

# Se encarga de aplicar el formato correspondiente (en este caso, JSON)
class Formateador

  def dar_formato(hash)
    JSON.pretty_generate(hash)
  end

  def leer(texto)
    JSON.parse(texto)
  end

end
