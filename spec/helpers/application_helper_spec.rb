require 'rails_helper'

describe ApplicationHelper do
  describe '#present_cep_address' do
    it 'presents nothing for a null address' do
      address = CepServiceResponse::Address.new(nil, nil, nil, nil)
      expect(helper.present_cep_address(address)).to eq('')
    end

    it 'presents a full address' do
      address = CepServiceResponse::Address.new('RUA MARILIA', 'JARDIM PAULISTA', 'SAO PAULO', 'SP')
      expect(helper.present_cep_address(address)).to eq('RUA MARILIA, JARDIM PAULISTA. SAO PAULO - SP')
    end

    it 'presents a generic address' do
      address = CepServiceResponse::Address.new(nil, nil, 'SAO PAULO', 'SP')
      expect(helper.present_cep_address(address)).to eq('SAO PAULO - SP')
    end
  end

  describe '#present_cep_error_message' do
    it 'presents an error message for a invalid cep' do
      expect(present_cep_error_message(:invalid)).to eq('Não foi possível consultar o CEP (CEP inválido).')
    end

    it 'presents an error message for not registered cep' do
      expect(present_cep_error_message(:not_registered)).to eq('Não foi possível consultar o CEP (CEP não registrado).')
    end

    it 'presents an error message for a not informed cep' do
      expect(present_cep_error_message(:not_informed)).to eq('Não foi possível consultar o CEP (CEP não informado).')
    end
  end
end
