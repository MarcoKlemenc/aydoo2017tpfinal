require 'rspec'
require_relative '../model/repositorio_calendarios'

describe 'Repositorio Calendarios' do

  it 'Debe crear un calendario a partir de un conjunto de datos correctos' do
    datos_calendario = {
        nombre: 'calendario 1'
    }
    repositorio = RepositorioCalendarios.new
    repositorio.crear_calendario(datos_calendario)
  end

  it 'Error al crear un calendario con el mismo nombre que otro ya existente' do
    datos_calendario = {
        nombre: 'calendario 1'
    }
    datos_otro_calendario = {
        nombre: 'calendario 1'
    }
    repositorio = RepositorioCalendarios.new
    repositorio.crear_calendario(datos_calendario)
    expect { repositorio.crear_calendario(datos_otro_calendario) }.to raise_error
  end

  it 'No deberia poder obtener un calendario que no existe en el repositorio' do
    repositorio = RepositorioCalendarios.new
    expect(repositorio.obtener_calendario('un nombre')).to eq nil
  end

  it 'Si pido eliminar un calendario que contenia el repositorio deberia obtener el calendario eliminado' do
    datos_calendario = {
        nombre: 'calendario 1'
    }
    gestor = RepositorioCalendarios.new
    calendario = gestor.crear_calendario(datos_calendario)
    expect(gestor.eliminar_calendario(calendario.nombre)).to eq calendario
  end

  it 'Si creo un calendario y solicito el diccionario de calendarios deberia contenerlo' do
    datos_calendario = {
        nombre: 'calendario 1'
    }
    gestor = RepositorioCalendarios.new
    calendario = gestor.crear_calendario(datos_calendario)
    expect(gestor.obtener_calendario(calendario.nombre)).to eq calendario
  end

  it 'No deberia dar error al intentar eliminar un calendario que no existe en el repositorio' do
    repositorio = RepositorioCalendarios.new
    expect(repositorio.eliminar_calendario('un calendario que no existe')).to eq nil
  end

  it 'Deberia obtener nil al obtener un calendario que no existe en el repositorio' do
    repositorio = RepositorioCalendarios.new
    expect(repositorio.obtener_calendario('un calendario que no existe')).to eq nil
  end

end