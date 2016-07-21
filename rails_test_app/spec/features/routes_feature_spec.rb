feature 'Routes page' do
  scenario 'Should display a list of routes at /rails_enquiries/routes' do

    visit '/rails_enquiries/routes'

    expect(page).to have_content('Global Rails Enquires')
    expect(page).to have_content('/rails_enquiries/routes')

  end
end
