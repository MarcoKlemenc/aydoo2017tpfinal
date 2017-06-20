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
  
  it 'Error al crear un recurso sin nombre' do
    expect do
      Recurso.new('')
    end.to raise_error(ExcepcionNombreRecurso)
  end
  
  it 'Deberia poder reservarse por un intervalo' do
    nombre = 'Recurso 1'
    recurso = Recurso.new(nombre)
    inicio = DateTime.now
    fin = DateTime.now + 10
    recurso.reservar(inicio, fin)
    expect(recurso.reservas[0]).to eq (inicio..fin)
  end
  
  it 'Error al almacenar reservas que se solapen' do
    nombre = 'Recurso 1'
    recurso = Recurso.new(nombre)
    inicio = DateTime.now
    fin = DateTime.now + 10
    recurso.reservar(inicio, fin)
    expect do
      recurso.reservar(inicio, fin)
    end.to raise_error(ExcepcionSolapamientoRecurso)
  end

end
