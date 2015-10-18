require 'rails_helper'

describe CepConsultation do
  it 'consults a valid cep' do
    cep = '01420020'

    cep_consultation = CepConsultation.new.call(cep)

    expect(cep_consultation.valid?).to be(true)
    expect(cep_consultation.message).to eq('RUA MARILIA, JARDIM PAULISTA. SAO PAULO - SP')
  end

  it 'consults a invalid cep' do
    cep = '775000000'

    cep_consultation = CepConsultation.new.call(cep)

    expect(cep_consultation.valid?).to be(false)
    expect(cep_consultation.message).to eq('Não foi possível consultar o CEP (CEP inválido).')
  end

  it 'consults a generic cep' do
    cep = '77500000'

    cep_consultation = CepConsultation.new.call(cep)

    expect(cep_consultation.valid?).to be(true)
    expect(cep_consultation.message).to eq('PORTO NACIONAL - TO')
  end

  it 'consults a not registered cep' do
    cep = '70000000'

    cep_consultation = CepConsultation.new.call(cep)

    expect(cep_consultation.valid?).to be(false)
    expect(cep_consultation.message).to eq('Não foi possível consultar o CEP (CEP não registrado).')
  end

  it 'consults a not informed cep' do
    cep = '00000000'

    cep_consultation = CepConsultation.new.call(cep)

    expect(cep_consultation.valid?).to be(false)
    expect(cep_consultation.message).to eq('Não foi possível consultar o CEP (CEP não informado).')
  end
end
