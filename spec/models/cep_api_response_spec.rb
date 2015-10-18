require 'rails_helper'

describe CepApiResponse do
  it 'builds a cep response for a valid cep' do
    api_response = {
      :cod_retorno => "0",
      :des_mensagem_sistema => "CODSQL=\"0\", MSGSQL=\"\", SQLSTA=\"00000\"",
      :des_mensagem_amigavel => nil,
      :des_endereco => "RUA",
      :des_nome_logradouro => "MARILIA",
      :ind_tipo_logradouro => "RUA MARILIA",
      :num_lote => nil,
      :nom_complemento => nil,
      :cod_complemento => nil,
      :nom_bairro => "JARDIM PAULISTA",
      :nom_localidade => "SAO PAULO",
      :cod_uf => "SP"
    }

    cep_service = described_class.new(api_response)

    expect(cep_service.return_code).to eq('0')
    expect(cep_service.address_name).to eq('RUA MARILIA')
    expect(cep_service.neighborhood).to eq('JARDIM PAULISTA')
    expect(cep_service.city).to eq('SAO PAULO')
    expect(cep_service.state).to eq('SP')
    expect(cep_service.error_message).to eq(nil)
  end

  it 'builds a cep response for a generic cep' do
    api_response = {
      :cod_retorno=>"0",
      :des_mensagem_sistema=>"CODSQL=\"0\", MSGSQL=\"\", SQLSTA=\"00000\"",
      :des_mensagem_amigavel=>nil,
      :des_endereco=>nil,
      :des_nome_logradouro=>nil,
      :ind_tipo_logradouro=>nil,
      :num_lote=>nil,
      :nom_complemento=>nil,
      :cod_complemento=>nil,
      :nom_bairro=>nil,
      :nom_localidade=>"PORTO NACIONAL",
      :cod_uf=>"TO"
    }

    cep_service = described_class.new(api_response)

    expect(cep_service.return_code).to eq('0')
    expect(cep_service.address_name).to eq(nil)
    expect(cep_service.neighborhood).to eq(nil)
    expect(cep_service.city).to eq('PORTO NACIONAL')
    expect(cep_service.state).to eq('TO')
    expect(cep_service.error_message).to eq(nil)
  end

  it 'builds a cep response for a invalid cep' do
    api_response = {
      :cod_retorno=>"-1",
      :des_mensagem_sistema=>"CODSQL=\"-1\", MSGSQL=\"Falha na execução da Stored Procedure SPBGE035: Nenhum resultado retornado.\", SQLSTA=\"Falha na execução da Stored Procedure SPBGE035: Nenhum resultado retornado.\"",
      :des_mensagem_amigavel=>"Falha na execução da Stored Procedure SPBGE035: Nenhum resultado retornado."
    }

    cep_service = described_class.new(api_response)

    expect(cep_service.return_code).to eq('-1')
    expect(cep_service.address_name).to eq(nil)
    expect(cep_service.neighborhood).to eq(nil)
    expect(cep_service.city).to eq(nil)
    expect(cep_service.state).to eq(nil)
    expect(cep_service.error_message).to eq('Falha na execução da Stored Procedure SPBGE035: Nenhum resultado retornado.')
  end

  it 'builds a cep response for a not registered cep' do
    api_response = {
      :cod_retorno=>"1",
      :des_mensagem_sistema=>"CODSQL=\"0\", MSGSQL=\"\", SQLSTA=\"02000\"",
      :des_mensagem_amigavel=>"CEP NAO CADASTRADO",
      :des_endereco=>nil,
      :des_nome_logradouro=>nil,
      :ind_tipo_logradouro=>nil,
      :num_lote=>nil,
      :nom_complemento=>nil,
      :cod_complemento=>nil,
      :nom_bairro=>nil,
      :nom_localidade=>nil,
      :cod_uf=>nil
    }

    cep_service = described_class.new(api_response)

    expect(cep_service.return_code).to eq('1')
    expect(cep_service.address_name).to eq(nil)
    expect(cep_service.neighborhood).to eq(nil)
    expect(cep_service.city).to eq(nil)
    expect(cep_service.state).to eq(nil)
    expect(cep_service.error_message).to eq('CEP NAO CADASTRADO')
  end

  it 'builds a cep response for a not registered cep' do
    api_response = {
      :cod_retorno=>"1",
      :des_mensagem_sistema=>"CODSQL=\"0\", MSGSQL=\"\", SQLSTA=\"02000\"",
      :des_mensagem_amigavel=>"SPBGE035 - CEP NAO INFORMADO",
      :des_endereco=>nil,
      :des_nome_logradouro=>nil,
      :ind_tipo_logradouro=>nil,
      :num_lote=>nil,
      :nom_complemento=>nil,
      :cod_complemento=>nil,
      :nom_bairro=>nil,
      :nom_localidade=>nil,
      :cod_uf=>nil
    }

    cep_service = described_class.new(api_response)

    expect(cep_service.return_code).to eq('1')
    expect(cep_service.address_name).to eq(nil)
    expect(cep_service.neighborhood).to eq(nil)
    expect(cep_service.city).to eq(nil)
    expect(cep_service.state).to eq(nil)
    expect(cep_service.error_message).to eq('SPBGE035 - CEP NAO INFORMADO')
  end
end
