class CepApiFakeClient
  def initialize(cep)
    @cep = cep
  end

  def call
    if @cep == '01420020'
      {
        :cod_retorno=>"0",
        :des_mensagem_amigavel=>nil,
        :ind_tipo_logradouro=>"RUA MARILIA",
        :nom_bairro=>"JARDIM PAULISTA",
        :nom_localidade=>"SAO PAULO",
        :cod_uf=>"SP"
      }
    elsif @cep == '775000000'
      {
        :cod_retorno=>"-1",
        :des_mensagem_amigavel=>"Falha na execução da Stored Procedure SPBGE035: Nenhum resultado retornado."
      }
    elsif @cep == '77500000'
      {
        :cod_retorno=>"0",
        :des_mensagem_amigavel=>nil,
        :ind_tipo_logradouro=>nil,
        :nom_bairro=>nil,
        :nom_localidade=>"PORTO NACIONAL",
        :cod_uf=>"TO"
      }
    elsif @cep == '70000000'
      {
        :cod_retorno=>"1",
        :des_mensagem_amigavel=>"CEP NAO CADASTRADO",
        :ind_tipo_logradouro=>nil,
        :nom_bairro=>nil,
        :nom_localidade=>nil,
        :cod_uf=>nil
      }
    elsif @cep == '00000000'
      {
        :cod_retorno=>"1",
        :des_mensagem_amigavel=>"SPBGE035 - CEP NAO INFORMADO",
        :ind_tipo_logradouro=>nil,
        :nom_bairro=>nil,
        :nom_localidade=>nil,
        :cod_uf=>nil
      }
    else
      raise "the given cep #{@cep} is not supported by this fake client"
    end
  end
end
