require 'rails_helper'

def get_cep_response(cep)
  CepApiClient.new(cep).call
end

describe 'Consult CEP from SOAP API' do
  it 'consults a valid cep' do
    cep = '01420020'

    cep_response = get_cep_response(cep)

    expect(cep_response).to eq({
      :cod_retorno=>"0",
      :des_mensagem_sistema=>"CODSQL=\"0\", MSGSQL=\"\", SQLSTA=\"00000\"",
      :des_mensagem_amigavel=>nil,
      :des_endereco=>"RUA",
      :des_nome_logradouro=>"MARILIA",
      :ind_tipo_logradouro=>"RUA MARILIA",
      :num_lote=>nil,
      :nom_complemento=>nil,
      :cod_complemento=>nil,
      :nom_bairro=>"JARDIM PAULISTA",
      :nom_localidade=>"SAO PAULO",
      :cod_uf=>"SP"
    })
  end

  it 'consults a generic cep' do
    cep = '77500000'

    cep_response = get_cep_response(cep)

    expect(cep_response).to eq({
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
    })
  end

  it 'consults a invalid cep' do
    cep = '775000000'

    cep_response = get_cep_response(cep)

    expect(cep_response).to eq({
      :cod_retorno=>"-1",
      :des_mensagem_sistema=>"CODSQL=\"-1\", MSGSQL=\"Falha na execução da Stored Procedure SPBGE035: Nenhum resultado retornado.\", SQLSTA=\"Falha na execução da Stored Procedure SPBGE035: Nenhum resultado retornado.\"",
      :des_mensagem_amigavel=>"Falha na execução da Stored Procedure SPBGE035: Nenhum resultado retornado."
    })
  end

  it 'consults a not registered cep' do
    cep = '70000000'

    cep_response = get_cep_response(cep)

    expect(cep_response).to eq({
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
    })
  end

  it 'consults a not informed cep' do
    cep = '00000000'

    cep_response = get_cep_response(cep)

    expect(cep_response).to eq({
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
    })
  end
end
