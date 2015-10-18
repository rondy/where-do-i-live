class AddressesController < ApplicationController
  def form
  end

  def consult_cep
    if params[:cep] == '01420020'
      @cep_is_valid = true
      @cep_consultation_message = 'RUA MARILA, JARDIM PAULISTA. SAO PAULO - SP'
    elsif params[:cep] == '77500000'
      @cep_is_valid = true
      @cep_consultation_message = 'PORTO NACIONAL - TO'
    elsif params[:cep] == '70000000'
      @cep_is_valid = false
      @cep_consultation_message = 'Não foi possível consultar o CEP (CEP não registrado).'
    elsif params[:cep] == '00000000'
      @cep_is_valid = false
      @cep_consultation_message = 'Não foi possível consultar o CEP (CEP não informado).'
    else
      @cep_is_valid = false
      @cep_consultation_message = 'Não foi possível consultar o CEP (CEP inválido).'
    end

    render :form
  end
end
