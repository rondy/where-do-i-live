class CepService
  def initialize(cep)
    @cep = cep
  end

  def call
    CepServiceResponse.new(
      CepApiResponse.new(
        CepApiClient.new(@cep).call
      )
    )
  end
end
