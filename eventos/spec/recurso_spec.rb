require 'rspec'
require_relative '../model/recurso'

describe 'Recurso' do
  it 'Se debe crear un recurso a partir de un nombre' do
    nombre = 'Recurso 1'
    Recurso.new(nombre)
  end

  it 'Deberia poder obtener el nombre' do
    nombre = 'Recurso 1'
    recurso = Recurso.new(nombre)
    expect(recurso.nombre).to eq nombre
  end

end
