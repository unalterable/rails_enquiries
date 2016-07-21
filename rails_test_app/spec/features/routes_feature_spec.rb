feature 'Routes page' do
  scenario 'Should display a list of routes at /rails_enquiries/routes' do

    visit '/rails_enquiries/routes'

    expect(page).to have_content('Global Rails Enquires')
    expect(page).to have_content('/rails_enquiries/routes')

  end

  scenario 'Routes should be links' do
    
    visit '/rails_enquiries/routes'
    click_link('route_link_id_0')

    expect(page).to have_content('Route Info')

  end


end

