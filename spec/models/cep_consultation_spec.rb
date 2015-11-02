require 'rails_helper'

describe CepConsultation do
  it 'consults a valid cep' do
    cep = '01420020'

    cep_consultation = CepConsultation.new.call(cep)

    expect(cep_consultation.valid?).to be(true)
    expect(cep_consultation.address).to be_a_kind_of(CepServiceResponse::Address)
    expect(cep_consultation.address.address_name).to eq('RUA MARILIA')
    expect(cep_consultation.address.neighborhood).to eq('JARDIM PAULISTA')
    expect(cep_consultation.address.city).to eq('SAO PAULO')
    expect(cep_consultation.address.state).to eq('SP')
    expect(cep_consultation.error_code).to be_nil
  end

  it 'consults a invalid cep' do
    cep = '775000000'

    cep_consultation = CepConsultation.new.call(cep)

    expect(cep_consultation.valid?).to be(false)
    expect(cep_consultation.address).to be_nil
    expect(cep_consultation.error_code).to eq(:invalid)
  end

  it 'consults a generic cep' do
    cep = '77500000'

    cep_consultation = CepConsultation.new.call(cep)

    expect(cep_consultation.valid?).to be(true)
    expect(cep_consultation.address).to be_a_kind_of(CepServiceResponse::Address)
    expect(cep_consultation.address.address_name).to eq(nil)
    expect(cep_consultation.address.neighborhood).to eq(nil)
    expect(cep_consultation.address.city).to eq('PORTO NACIONAL')
    expect(cep_consultation.address.state).to eq('TO')
    expect(cep_consultation.error_code).to be_nil
  end

  it 'consults a not registered cep' do
    cep = '70000000'

    cep_consultation = CepConsultation.new.call(cep)

    expect(cep_consultation.valid?).to be(false)
    expect(cep_consultation.address).to be_nil
    expect(cep_consultation.error_code).to eq(:not_registered)
  end

  it 'consults a not informed cep' do
    cep = '00000000'

    cep_consultation = CepConsultation.new.call(cep)

    expect(cep_consultation.valid?).to be(false)
    expect(cep_consultation.address).to be_nil
    expect(cep_consultation.error_code).to eq(:not_informed)
  end
end
