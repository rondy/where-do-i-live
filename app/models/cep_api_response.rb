class CepApiResponse
  def initialize(api_response)
    @api_response = Hash(api_response)
  end

  def return_code
    @api_response.fetch(:cod_retorno)
  end

  def address_name
    @api_response.fetch(:ind_tipo_logradouro, nil)
  end

  def neighborhood
    @api_response.fetch(:nom_bairro, nil)
  end

  def city
    @api_response.fetch(:nom_localidade, nil)
  end

  def state
    @api_response.fetch(:cod_uf, nil)
  end

  def error_message
    @api_response.fetch(:des_mensagem_amigavel, nil)
  end
end
