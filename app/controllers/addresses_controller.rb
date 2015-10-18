class AddressesController < ApplicationController
  def form
  end

  def consult_cep
    @cep_consultation = perform_cep_consultation(params[:cep])

    render :form
  end

  private

  def perform_cep_consultation(cep)
    CepConsultation.new.call(cep)
  end
end
