require 'rails_helper'

describe CepServiceResponse do
  it 'returns a valid cep response' do
    cep_api_response = OpenStruct.new(
      return_code: CepServiceResponse::VALID_RETURN_CODE,
      address_name: 'RUA MARILIA',
      neighborhood: 'JARDIM PAULISTA',
      city: 'SAO PAULO',
      state: 'SP',
    )

    subject = described_class.new(cep_api_response)

    expect(subject.valid?).to be(true)
    expect(subject.not_registered?).to be(false)
    expect(subject.not_informed?).to be(false)
    expect(subject.address).to be_a_kind_of(CepServiceResponse::Address)
  end

  it 'returns a valid generic cep response' do
    cep_api_response = OpenStruct.new(
      return_code: CepServiceResponse::VALID_RETURN_CODE,
      address_name: nil,
      neighborhood: nil,
      city: 'SAO PAULO',
      state: 'SP',
    )

    subject = described_class.new(cep_api_response)

    expect(subject.valid?).to be(true)
    expect(subject.not_registered?).to be(false)
    expect(subject.not_informed?).to be(false)
    expect(subject.address).to be_a_kind_of(CepServiceResponse::Address)
  end

  it 'returns a not registered cep response' do
    cep_api_response = OpenStruct.new(
      return_code: CepServiceResponse::INVALID_RETURN_CODE,
      error_message: CepServiceResponse::CEP_NOT_REGISTERED
    )

    subject = described_class.new(cep_api_response)

    expect(subject.valid?).to be(false)
    expect(subject.not_registered?).to be(true)
    expect(subject.not_informed?).to be(false)
    expect(subject.address).to be_a_kind_of(CepServiceResponse::Address)
  end

  it 'returns a not informed cep response' do
    cep_api_response = OpenStruct.new(
      return_code: CepServiceResponse::INVALID_RETURN_CODE,
      error_message: CepServiceResponse::CEP_NOT_INFORMED
    )

    subject = described_class.new(cep_api_response)

    expect(subject.valid?).to be(false)
    expect(subject.not_registered?).to be(false)
    expect(subject.not_informed?).to be(true)
    expect(subject.address).to be_a_kind_of(CepServiceResponse::Address)
  end
end
