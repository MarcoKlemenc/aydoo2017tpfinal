require 'rspec'
require_relative '../model/mapeador_frecuencias'

describe 'Mapeador Frecuencias' do
  it 'Se mapea la frecuencia diaria' do
    mapeador = MapeadorFrecuencias.new
    frecuencia_diaria = 1
    expect(mapeador.frecuencias.fetch("diaria").frecuencia).to eq frecuencia_diaria
  end
  
  it 'Se mapea la frecuencia semanal' do
    mapeador = MapeadorFrecuencias.new
    frecuencia_semanal = 7
    expect(mapeador.frecuencias.fetch("semanal").frecuencia).to eq frecuencia_semanal
  end
  
  it 'Se mapea la frecuencia mensual' do
    mapeador = MapeadorFrecuencias.new
    frecuencia_mensual = 30
    expect(mapeador.frecuencias.fetch("mensual").frecuencia).to eq frecuencia_mensual
  end
  
  it 'Se mapea la frecuencia anual' do
    mapeador = MapeadorFrecuencias.new
    frecuencia_anual = 365
    expect(mapeador.frecuencias.fetch("anual").frecuencia).to eq frecuencia_anual
  end

end
