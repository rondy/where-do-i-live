class CepConsultation
  def call(cep)
    response = get_cep_response(cep)

    if cep_is_valid?(response)
      cep_is_valid = true
      cep_consultation_message = build_valid_cep_address(response)
    elsif cep_is_not_registered?(response)
      cep_is_valid = false
      cep_consultation_message = 'Não foi possível consultar o CEP (CEP não registrado).'
    elsif cep_is_not_informed?(response)
      cep_is_valid = false
      cep_consultation_message = 'Não foi possível consultar o CEP (CEP não informado).'
    else
      cep_is_valid = false
      cep_consultation_message = 'Não foi possível consultar o CEP (CEP inválido).'
    end

    OpenStruct.new(
      valid?: cep_is_valid,
      message: cep_consultation_message,
    )
  end

  private

  def cep_is_valid?(response)
    response[:cod_retorno] == "0"
  end

  def build_valid_cep_address(response)
    part_1 = [response[:ind_tipo_logradouro], response[:nom_bairro]].compact.join(', ')
    part_2 = [response[:nom_localidade], response[:cod_uf]].compact.join(' - ')
    [part_1, part_2].reject(&:blank?).join('. ')
  end

  def cep_is_not_registered?(response)
    response[:cod_retorno] == '1' && response[:des_mensagem_amigavel] == "CEP NAO CADASTRADO"
  end

  def cep_is_not_informed?(response)
    response[:cod_retorno] == '1' && response[:des_mensagem_amigavel] == "SPBGE035 - CEP NAO INFORMADO"
  end

  def get_cep_response(cep)
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
    response.body[:consulta_cep_response][:retorno]
  end
end
