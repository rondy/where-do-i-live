require 'rails_helper'

feature 'User can consult a cep' do
  scenario 'User can consult a valid cep' do
    visit root_url

    fill_in :cep, with: '01420020'
    click_button 'Consultar CEP'

    expect(page).to have_css('.cep-valid', text: 'RUA MARILIA, JARDIM PAULISTA. SAO PAULO - SP')
  end

  scenario 'User can consult a invalid cep' do
    visit root_url

    fill_in :cep, with: '775000000'
    click_button 'Consultar CEP'

    expect(page).to have_css('.cep-invalid', text: 'Não foi possível consultar o CEP (CEP inválido).')
  end
end
