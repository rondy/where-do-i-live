require 'rails_helper'

feature 'User can consult a cep' do
  scenario 'User can consult a valid cep' do
    visit root_url

    fill_in :cep, with: '01420020'
    click_button 'Consultar CEP'

    expect(page).to have_content('RUA MARILA, JARDIM PAULISTA. SAO PAULO - SP')
  end

  scenario 'User can consult a invalid cep' do
    visit root_url

    fill_in :cep, with: '775000000'
    click_button 'Consultar CEP'

    expect(page).to have_content('Não foi possível consultar o CEP (CEP inválido).')
  end

  scenario 'User can consult a generic cep' do
    visit root_url

    fill_in :cep, with: '77500000'
    click_button 'Consultar CEP'

    expect(page).to have_content('PORTO NACIONAL - TO')
  end

  scenario 'User can consult a not registered cep' do
    visit root_url

    fill_in :cep, with: '70000000'
    click_button 'Consultar CEP'

    expect(page).to have_content('Não foi possível consultar o CEP (CEP não registrado).')
  end

  scenario 'User can consult a not informed cep' do
    visit root_url

    fill_in :cep, with: '00000000'
    click_button 'Consultar CEP'

    expect(page).to have_content('Não foi possível consultar o CEP (CEP não informado).')
  end
end
