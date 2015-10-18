class CepApiClient
  def initialize(cep)
    @cep = cep
  end

  def call
    fetch_response
      .body[:consulta_cep_response][:retorno]
  end

  private

  def fetch_response
    @response ||= savon_client.call(:consulta_cep, message: request_body)
  end

  def request_body
    {
      dados_entrada: {
        cod_sistema: 'GE',
        num_cep: @cep
      }
    }
  end

  def savon_client
    Savon.client do
      wsdl 'https://apiproxy-dev.cxdigital.io/servicosdev2/GEWSV0002_ConsultaCep?wsdl'
      endpoint 'https://apiproxy-dev.cxdigital.io/servicosdev2/GEWSV0002_ConsultaCep'
      basic_auth('usr_soa_ge', '66f82a4')
    end
  end
end
