require 'rspec'
require_relative '../model/validador_unicidad_evento'

describe 'Validador Unicidad Evento' do
  it 'Deberia validar un id en un repositorio sin calendarios' do
    evento = double('Evento')
    allow(evento).to receive(:id).and_return('id_1')
    calendarios = []
    ValidadorUnicidadEvento.validar(calendarios, evento.id)
  end

  it 'Deberia validar un id en un repositorio con un calendario sin eventos' do
    evento = double('Evento')
    allow(evento).to receive(:id).and_return('id_1')
    calendario = double('Calendario')
    allow(calendario).to receive(:eventos).and_return({})
    calendarios = [calendario]
    ValidadorUnicidadEvento.validar(calendarios, evento.id)
  end

  it 'Error al validar un id existente' do
    evento = double('Evento')
    allow(evento).to receive(:id).and_return('id_1')
    calendario = double('Calendario')
    allow(calendario).to receive(:eventos).and_return({"id_1" => evento})
    calendarios = [calendario]
    expect do
      ValidadorUnicidadEvento.validar(calendarios, evento.id)
    end.to raise_error(ExcepcionUnicidadGlobalEvento)
  end
end
