class AddressesController < ApplicationController
  def form
  end

  def consult_cep
    if params[:cep] == '01420020'
      @consult_message = 'RUA MARILA, JARDIM PAULISTA. SAO PAULO - SP'
    else
      @consult_message = 'Não foi possível consultar o CEP (CEP inválido).'
    end

    render :form
  end
end
