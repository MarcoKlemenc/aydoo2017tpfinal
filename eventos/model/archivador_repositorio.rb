# Encargada de la persistencia del repositorio
class ArchivadorRepositorio
  def self.cargar(archivo)
    if File.file?(archivo)
      archivo= File.open(archivo, "r")
      Marshal.load(archivo)
    end
  end

  def self.guardar(repositorio, archivo)
    archivo = File.open(archivo, "w")
    Marshal.dump(repositorio, archivo)
    archivo.close
  end
end
