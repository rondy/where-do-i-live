class CepConsultation
  def call(cep)
    cep_response = get_cep_service_response(cep)

    if cep_response.valid?
      build_valid_consultation_response(
        address: cep_response.address
      )
    elsif cep_response.not_registered?
      build_invalid_consultation_response(
        error_code: :not_registered
      )
    elsif cep_response.not_informed?
      build_invalid_consultation_response(
        error_code: :not_informed
      )
    else
      build_invalid_consultation_response(
        error_code: :invalid
      )
    end
  end

  private

  def build_valid_consultation_response(address:)
    OpenStruct.new(
      valid?: true,
      address: address,
      error_code: nil
    )
  end

  def build_invalid_consultation_response(error_code:)
    OpenStruct.new(
      valid?: false,
      address: nil,
      error_code: error_code
    )
  end

  def get_cep_service_response(cep)
    CepService.new(cep).call
  end
end
