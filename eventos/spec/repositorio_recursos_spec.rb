require 'rspec'
require_relative '../model/repositorio_recursos'

describe 'Repositorio Recursos' do
  it 'Debe poder almacenar un recurso' do
    recurso = double('Recurso 1')
    allow(recurso).to receive(:nombre).and_return('Recurso 1')
    repositorio = RepositorioRecursos.new
    repositorio.almacenar_recurso(recurso)
  end

  it 'Debe poder almacenar varios recursos' do
    recurso = double('Recurso 1')
    allow(recurso).to receive(:nombre).and_return('Recurso 1')
    otro_recurso = double('Recurso 2')
    allow(otro_recurso).to receive(:nombre).and_return('Recurso 2')
    repositorio = RepositorioRecursos.new
    repositorio.almacenar_recurso(recurso)
    repositorio.almacenar_recurso(otro_recurso)
  end

  it 'Error al almacenar un recurso con una identificacion ya almacenada' do
    recurso = double('Recurso 1')
    allow(recurso).to receive(:nombre).and_return('Recurso 1')
    otro_recurso = double('Recurso 1')
    allow(otro_recurso).to receive(:nombre).and_return('Recurso 1')
    repositorio = RepositorioRecursos.new
    repositorio.almacenar_recurso(recurso)
    expect do
      repositorio.almacenar_recurso(otro_recurso)
    end.to raise_error(ExcepcionUnicidadRecurso)
  end

end