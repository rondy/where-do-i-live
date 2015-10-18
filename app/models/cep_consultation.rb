class CepConsultation
  def call(cep)
    cep_response = get_cep_service_response(cep)

    if cep_response.valid?
      build_valid_consultation_response(
        message: cep_response.full_address
      )
    elsif cep_response.not_registered?
      build_invalid_consultation_response(
        message: 'Não foi possível consultar o CEP (CEP não registrado).'
      )
    elsif cep_response.not_informed?
      build_invalid_consultation_response(
        message: 'Não foi possível consultar o CEP (CEP não informado).'
      )
    else
      build_invalid_consultation_response(
        message: 'Não foi possível consultar o CEP (CEP inválido).'
      )
    end
  end

  private

  def build_valid_consultation_response(message:)
    OpenStruct.new(
      valid?: true,
      message: message
    )
  end

  def build_invalid_consultation_response(message:)
    OpenStruct.new(
      valid?: false,
      message: message
    )
  end

  def get_cep_service_response(cep)
    CepService.new(cep).call
  end
end
