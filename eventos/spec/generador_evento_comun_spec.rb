require 'rspec'
require_relative '../model/generador_evento_comun'

describe 'Generador Evento Comun' do
  it 'El generador de evento comun genera uno' do
    uno = 1
    generador = GeneradorEventoComun.new (uno)
    params = {'id' => "id_1",
              'nombre' => "Evento 1",
              'inicio' => DateTime.now,
              'fin' => DateTime.now,
    }
    expect(generador.generar_evento(params).nombre).to eq "Evento 1"
  end

  it 'Llama al generar del siguiente al no pasarle id' do
    hash = {}
    dos = 2
    siguiente = double('Siguiente generador')
    allow(siguiente).to receive(:generar_evento).and_return(dos)
    generador = GeneradorEventoComun.new (siguiente)
    expect(generador.generar_evento(hash)).to eq dos
  end
end
