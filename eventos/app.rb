require 'sinatra'

require_relative 'model/repositorio_recursos'
require_relative 'model/recurso'
require_relative 'model/archivador_repositorio'
require_relative 'model/repositorio_calendarios'
require_relative 'model/calendario'
require_relative 'model/evento'
require_relative 'model/evento_recurrente'
require_relative 'model/formateador'
require_relative 'model/validador_unicidad_evento'
require_relative 'model/cadena_generacion_eventos'

archivo_calendarios = "calendarios.txt"
archivo_recursos = "recursos.txt"

repositorio_calendarios = ArchivadorRepositorio.cargar(archivo_calendarios) || RepositorioCalendarios.new
repositorio_recursos = ArchivadorRepositorio.cargar(archivo_recursos) || RepositorioRecursos.new
formateador = Formateador.new
cadena = CadenaGeneracionEventos.new

post '/calendarios' do
  begin
    request.body.rewind
    body = formateador.leer(request.body.read)
    nombre_calendario = body['nombre']
    calendario = Calendario.new(nombre_calendario)
    repositorio_calendarios.almacenar_calendario(calendario)
    ArchivadorRepositorio.guardar(repositorio_calendarios, archivo_calendarios)
    formateador.dar_formato(calendario.to_h)
  rescue ExcepcionUnicidadCalendario,
      ExcepcionNombreCalendario
    status 400
  end
end

delete '/calendarios/:nombre' do
  begin
    nombre_calendario = params[:nombre]
    calendario = repositorio_calendarios.obtener_calendario(nombre_calendario)
    calendario.eventos.values.each do |e|
      e.eliminar_reservas
    end
    repositorio_calendarios.eliminar_calendario(nombre_calendario)
    ArchivadorRepositorio.guardar(repositorio_calendarios, archivo_calendarios)
    ArchivadorRepositorio.guardar(repositorio_recursos, archivo_recursos)
  rescue ExcepcionCalendarioInexistente
    status 404
  end
end

get '/calendarios' do
  salida = []
  repositorio_calendarios.calendarios.values.each {|calendario| salida << calendario.to_h}
  formateador.dar_formato(salida)
end

get '/calendarios/:nombre' do
  begin
    nombre_calendario = params[:nombre]
    calendario = repositorio_calendarios.obtener_calendario(nombre_calendario)
    formateador.dar_formato(calendario.to_h)
  rescue ExcepcionCalendarioInexistente
    status 404
  end
end

post '/eventos' do
  begin
    request.body.rewind
    body = formateador.leer(request.body.read)
    ValidadorUnicidadEvento.validar(repositorio_calendarios.calendarios.values, body['id'])
    nombre_calendario = body['calendario']
    calendario = repositorio_calendarios.obtener_calendario(nombre_calendario)
    nombre_recurso = body['recurso']
    if nombre_recurso
      body['recurso'] = repositorio_recursos.obtener_recurso(nombre_recurso)
    end
    body['inicio'] = DateTime.parse(body['inicio'])
    body['fin'] = DateTime.parse(body['fin'])
    if body['recurrencia']
      body['recurrencia']['fin'] = DateTime.parse(body['recurrencia']['fin'])
    end
    evento = cadena.generar_evento(body)
    
    calendario.almacenar_evento(evento)
    ArchivadorRepositorio.guardar(repositorio_calendarios, archivo_calendarios)
    ArchivadorRepositorio.guardar(repositorio_recursos, archivo_recursos)
  rescue ExcepcionCalendarioInexistente,
      ExcepcionIntervaloErroneo,
      ExcepcionIntervaloMaximo,
      ExcepcionUnicidadEvento,
      ExcepcionSolapamientoEvento,
      ExcepcionUnicidadGlobalEvento,
      ExcepcionRecursoInexistente,
      ExcepcionSolapamientoRecurso
    repositorio_recursos = ArchivadorRepositorio.cargar(archivo_recursos) || RepositorioRecursos.new
    status 400
  end
end

put '/eventos' do
  begin
    request.body.rewind
    body = formateador.leer(request.body.read)
    id_evento = body['id']

    repositorio_evento = nil
    repositorio_calendarios.calendarios.values.each do |calendario|
      repositorio_evento = calendario if calendario.eventos.key?(id_evento)
      repositorio_evento && break
    end
    raise ExcepcionEventoInexistente unless repositorio_evento

    evento_original = repositorio_evento.obtener_evento(id_evento)
    nombre_original = evento_original.nombre
    inicio_original = evento_original.inicio
    fin_original = evento_original.fin
    frecuencia_original = evento_original.instance_variable_defined?(:@frecuencia) && evento_original.frecuencia
    fin_recurrencia_original = evento_original.instance_variable_defined?(:@fin_recurrencia) && evento_original.fin_recurrencia

    body['nombre'] = body.key?('nombre') ? body['nombre'] : nombre_original
    body['inicio'] = body.key?('inicio') ? DateTime.parse(body['inicio']) : inicio_original
    body['fin'] = body.key?('fin') ? DateTime.parse(body['fin']) : fin_original

    nombre_recurso = body['recurso']
    if nombre_recurso || evento_original.recurso
      body['recurso'] = body.key?('recurso') ? repositorio_recursos.obtener_recurso(nombre_recurso) : evento_original.recurso
    end

    if body.key?('recurrencia')
      body['recurrencia']['frecuencia'] = body.key?('recurrencia') && body['recurrencia'].key?('frecuencia') ? body['recurrencia']['frecuencia'] : frecuencia_original
      body['recurrencia']['fin'] = body.key?('recurrencia') && body['recurrencia'].key?('fin') ? DateTime.parse(body['recurrencia']['fin']) : fin_recurrencia_original
    end

    repositorio_evento.eliminar_evento(id_evento)
    evento_reemplazante = cadena.generar_evento(body)

    begin
      repositorio_evento.almacenar_evento(evento_reemplazante)
    rescue
      repositorio_evento.almacenar_evento(evento_original)
      status 400
    end
    ArchivadorRepositorio.guardar(repositorio_calendarios, archivo_calendarios)
    ArchivadorRepositorio.guardar(repositorio_recursos, archivo_recursos)

  rescue ExcepcionCalendarioInexistente,
      ExcepcionEventoInexistente,
      ExcepcionIntervaloErroneo,
      ExcepcionIntervaloMaximo,
      ExcepcionSolapamientoEvento,
      ExcepcionRecursoInexistente,
      ExcepcionSolapamientoRecurso
    repositorio_recursos = ArchivadorRepositorio.cargar(archivo_recursos) || RepositorioRecursos.new
    status 400
  end
end

delete '/eventos/:id' do
  id_evento = params[:id]
  repositorio_evento = nil
  repositorio_calendarios.calendarios.values.each do |calendario|
    repositorio_evento = calendario if calendario.eventos.key?(id_evento)
    repositorio_evento && break
  end
  begin
    evento = repositorio_evento.obtener_evento(id_evento)
    repositorio_evento.eliminar_evento(id_evento)
    ArchivadorRepositorio.guardar(repositorio_calendarios, archivo_calendarios)
    ArchivadorRepositorio.guardar(repositorio_recursos, archivo_recursos)
  rescue
    status 404
  end
end

get '/eventos' do
  eventos = []
  calendarios = nil
  nombre = params['calendario']
  begin
    if !nombre.nil?
      calendarios = [repositorio_calendarios.obtener_calendario(nombre)]
    else
      calendarios = repositorio_calendarios.calendarios.values
    end
    calendarios.each do |calendario|
      calendario.eventos.values.each do |evento|
        eventos << evento
      end
    end
    salida = []
    eventos.each {|evento| salida << evento.to_h}
    formateador.dar_formato(salida)
  rescue ExcepcionCalendarioInexistente
    status 400
  end
end

get '/eventos/:id' do
  begin
    id_evento = params[:id]
    repositorio_evento = nil
    repositorio_calendarios.calendarios.values.each do |calendario|
      repositorio_evento = calendario if calendario.eventos.key?(id_evento)
      repositorio_evento && break
    end
    raise ExcepcionEventoInexistente unless repositorio_evento
    evento = repositorio_evento.obtener_evento(id_evento)
    formateador.dar_formato(evento.to_h)
  rescue ExcepcionEventoInexistente
    status 404
  end
end

get '/recursos' do
  salida = []
  repositorio_recursos.recursos.values.each {|recurso| salida << recurso.to_h}
  formateador.dar_formato(salida)
end

delete '/recursos/:nombre' do
  begin
    nombre_recurso = params[:nombre]
    recurso = repositorio_recursos.obtener_recurso(nombre_recurso)
    repositorio_calendarios.calendarios.values.each do |c|
      c.eventos.values.each do |e|
        if e.recurso == recurso
          e.recurso = nil
        end
      end
    end
    repositorio_recursos.eliminar_recurso(nombre_recurso)
    ArchivadorRepositorio.guardar(repositorio_recursos, archivo_recursos)
  rescue ExcepcionRecursoInexistente
    status 404
  end
end

post '/recursos' do
  begin
    request.body.rewind
    body = formateador.leer(request.body.read)
    nombre_recurso = body['nombre']
    recurso = Recurso.new(nombre_recurso)
    repositorio_recursos.almacenar_recurso(recurso)
    ArchivadorRepositorio.guardar(repositorio_recursos, archivo_recursos)
    formateador.dar_formato(recurso.to_h)
  rescue ExcepcionUnicidadRecurso
    status 400
  end
end
