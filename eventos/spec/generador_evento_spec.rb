require 'rspec'
require_relative '../model/generador_evento'

describe 'Generador Evento' do
  it 'El generador de evento fija un siguiente' do
    uno = 1
    generador = GeneradorEvento.new (uno)
    expect(generador.siguiente).to eq uno
  end

  it 'El generador de evento llama al generar del siguiente' do
    uno = 1
    dos = 2
    siguiente = double('Siguiente generador')
    allow(siguiente).to receive(:generar_evento).and_return(dos)
    generador = GeneradorEvento.new (siguiente)
    expect(generador.generar_evento(uno)).to eq dos
  end

  it 'Devuelve nil si no tiene un siguiente' do
    uno = 1
    generador = GeneradorEvento.new (nil)
    expect(generador.generar_evento(uno)).to eq nil
  end

end
