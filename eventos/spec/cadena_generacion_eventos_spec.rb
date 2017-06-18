require 'rspec'
require_relative '../model/cadena_generacion_eventos'

describe 'Cadena Generacion Eventos' do
  it 'Hay dos eslabones en la cadena' do
    cadena = CadenaGeneracionEventos.new
    expect(cadena.generadores.size).to eq 2
  end

  
end
