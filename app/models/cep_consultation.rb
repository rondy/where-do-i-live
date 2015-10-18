class CepConsultation
  def call(cep)
    if cep == '01420020'
      cep_is_valid = true
      cep_consultation_message = 'RUA MARILA, JARDIM PAULISTA. SAO PAULO - SP'
    elsif cep == '77500000'
      cep_is_valid = true
      cep_consultation_message = 'PORTO NACIONAL - TO'
    elsif cep == '70000000'
      cep_is_valid = false
      cep_consultation_message = 'Não foi possível consultar o CEP (CEP não registrado).'
    elsif cep == '00000000'
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
end
