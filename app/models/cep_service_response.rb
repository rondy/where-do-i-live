class CepServiceResponse
  VALID_RETURN_CODE = '0'
  INVALID_RETURN_CODE = '1'
  CEP_NOT_REGISTERED = 'CEP NAO CADASTRADO'
  CEP_NOT_INFORMED = 'SPBGE035 - CEP NAO INFORMADO'

  def initialize(cep_api_response)
    @cep_api_response = cep_api_response
  end

  def full_address
    adress_part_1 = [
      @cep_api_response.address_name,
      @cep_api_response.neighborhood
    ].compact.join(', ')

    adress_part_2 = [
      @cep_api_response.city,
      @cep_api_response.state
    ].compact.join(' - ')

    [adress_part_1, adress_part_2]
      .reject(&:blank?).join('. ')
  end

  def valid?
    @cep_api_response.return_code == VALID_RETURN_CODE
  end

  def not_registered?
    @cep_api_response.return_code == INVALID_RETURN_CODE &&
    @cep_api_response.error_message == CEP_NOT_REGISTERED
  end

  def not_informed?
    @cep_api_response.return_code == INVALID_RETURN_CODE &&
    @cep_api_response.error_message == CEP_NOT_INFORMED
  end
end
