require 'rspec'
require_relative '../model/generador_evento_comun'

describe 'Generador Evento Comun' do
  it 'El generador de evento comun genera uno' do
    uno = 1
    generador = GeneradorEventoComun.new (uno)
    params = {'id' => "id_1",
              'nombre' => "Evento 1",
              'inicio' => "2017-01-01T12:00:00-03:00",
              'fin' => "2017-01-01T16:00:00-03:00",
             }
    expect(generador.generar_evento(params).nombre).to eq "Evento 1"
  end
  
end
