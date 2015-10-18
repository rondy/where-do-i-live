class CepConsultation
  attr_accessor :api_client

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
    response.return_code == "0"
  end

  def build_valid_cep_address(response)
    address_part_1 = [
      response.address_name,
      response.neighborhood
    ].compact.join(', ')

    address_part_2 = [
      response.city,
      response.state
    ].compact.join(' - ')

    [address_part_1, address_part_2]
      .reject(&:blank?).join('. ')
  end

  def cep_is_not_registered?(response)
    response.return_code == '1' && response.error_message == "CEP NAO CADASTRADO"
  end

  def cep_is_not_informed?(response)
    response.return_code == '1' && response.error_message == "SPBGE035 - CEP NAO INFORMADO"
  end

  def get_cep_response(cep)
    CepApiResponse.new(api_client.new(cep).call)
  end

  def api_client
    @api_client ||= CepApiClient
  end
end
