module ApplicationHelper
  def present_cep_address(address)
    adress_part_1 = [
      address.address_name,
      address.neighborhood
    ].compact.join(', ')

    adress_part_2 = [
      address.city,
      address.state
    ].compact.join(' - ')

    [adress_part_1, adress_part_2]
      .reject(&:blank?).join('. ')
  end

  def present_cep_error_message(error_code)
    case error_code
    when :not_registered
      'Não foi possível consultar o CEP (CEP não registrado).'
    when :not_informed
      'Não foi possível consultar o CEP (CEP não informado).'
    when :invalid
      'Não foi possível consultar o CEP (CEP inválido).'
    else
      ''
    end
  end
end
