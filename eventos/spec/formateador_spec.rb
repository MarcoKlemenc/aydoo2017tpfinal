require 'rspec'
require_relative '../model/formateador'

describe 'Formateador' do
  it 'Deberia dar un texto con formato a partir de un hash' do
    hash = {a: "b", c: "d"}
    texto = '{
  "a": "b",
  "c": "d"
}'
    formateador = Formateador.new
    expect(formateador.dar_formato(hash)).to eq texto
  end

  it 'Deberia dar un hash a partir de un texto con formato' do
    texto = '{
  "a": "b",
  "c": "d"
}'
    hash = {"a" => "b", "c" => "d"}
    formateador = Formateador.new
    expect(formateador.leer(texto)).to eq hash
  end
end
