require 'rspec'
require_relative '../model/generador_evento_recurrente'

describe 'Generador Evento Recurrente' do
  it 'El generador de evento recurrente genera uno al pasarle los parámetros correctos' do
    uno = 1
    generador = GeneradorEventoRecurrente.new (uno)
    recurrencia = {'frecuencia' => "semanal",
                   'fin' => DateTime.now + 1
    }
    params = {'id' => "id_1",
              'nombre' => "Evento 1",
              'inicio' => DateTime.now,
              'fin' => DateTime.now,
              'recurrencia' => recurrencia
    }
    expect(generador.generar_evento(params).nombre).to eq "Evento 1"
  end

  it 'Llama al generar del siguiente al no pasarle recurrencia' do
    hash = {}
    dos = 2
    siguiente = double('Siguiente generador')
    allow(siguiente).to receive(:generar_evento).and_return(dos)
    generador = GeneradorEventoRecurrente.new (siguiente)
    expect(generador.generar_evento(hash)).to eq dos
  end

end
