require 'rails_helper'

describe 'Consult CEP from SOAP API' do
  it 'consults a valid cep' do
    cep = '01420020'

    savon_client = Savon.client do
      wsdl 'https://apiproxy-dev.cxdigital.io/servicosdev2/GEWSV0002_ConsultaCep?wsdl'
      endpoint 'https://apiproxy-dev.cxdigital.io/servicosdev2/GEWSV0002_ConsultaCep'
      basic_auth('usr_soa_ge', '66f82a4')
    end

    request_body = {
      dados_entrada: {
        cod_sistema: 'GE',
        num_cep: cep
      }
    }

    response = savon_client.call(:consulta_cep, message: request_body)
    cep_response = response.body[:consulta_cep_response][:retorno]

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

    savon_client = Savon.client do
      wsdl 'https://apiproxy-dev.cxdigital.io/servicosdev2/GEWSV0002_ConsultaCep?wsdl'
      endpoint 'https://apiproxy-dev.cxdigital.io/servicosdev2/GEWSV0002_ConsultaCep'
      basic_auth('usr_soa_ge', '66f82a4')
    end

    request_body = {
      dados_entrada: {
        cod_sistema: 'GE',
        num_cep: cep
      }
    }

    response = savon_client.call(:consulta_cep, message: request_body)
    cep_response = response.body[:consulta_cep_response][:retorno]

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

    savon_client = Savon.client do
      wsdl 'https://apiproxy-dev.cxdigital.io/servicosdev2/GEWSV0002_ConsultaCep?wsdl'
      endpoint 'https://apiproxy-dev.cxdigital.io/servicosdev2/GEWSV0002_ConsultaCep'
      basic_auth('usr_soa_ge', '66f82a4')
    end

    request_body = {
      dados_entrada: {
        cod_sistema: 'GE',
        num_cep: cep
      }
    }

    response = savon_client.call(:consulta_cep, message: request_body)
    cep_response = response.body[:consulta_cep_response][:retorno]

    expect(cep_response).to eq({
      :cod_retorno=>"-1",
      :des_mensagem_sistema=>"CODSQL=\"-1\", MSGSQL=\"Falha na execução da Stored Procedure SPBGE035: Nenhum resultado retornado.\", SQLSTA=\"Falha na execução da Stored Procedure SPBGE035: Nenhum resultado retornado.\"",
      :des_mensagem_amigavel=>"Falha na execução da Stored Procedure SPBGE035: Nenhum resultado retornado."
    })
  end

  it 'consults a not registered cep' do
    cep = '70000000'

    savon_client = Savon.client do
      wsdl 'https://apiproxy-dev.cxdigital.io/servicosdev2/GEWSV0002_ConsultaCep?wsdl'
      endpoint 'https://apiproxy-dev.cxdigital.io/servicosdev2/GEWSV0002_ConsultaCep'
      basic_auth('usr_soa_ge', '66f82a4')
    end

    request_body = {
      dados_entrada: {
        cod_sistema: 'GE',
        num_cep: cep
      }
    }

    response = savon_client.call(:consulta_cep, message: request_body)
    cep_response = response.body[:consulta_cep_response][:retorno]

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

    savon_client = Savon.client do
      wsdl 'https://apiproxy-dev.cxdigital.io/servicosdev2/GEWSV0002_ConsultaCep?wsdl'
      endpoint 'https://apiproxy-dev.cxdigital.io/servicosdev2/GEWSV0002_ConsultaCep'
      basic_auth('usr_soa_ge', '66f82a4')
    end

    request_body = {
      dados_entrada: {
        cod_sistema: 'GE',
        num_cep: cep
      }
    }

    response = savon_client.call(:consulta_cep, message: request_body)
    cep_response = response.body[:consulta_cep_response][:retorno]

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
