feature 'Route Info page' do
  before(:each) do
    visit '/rails_enquiries/routes'
    click_link('route_link_id_0')
  end

  scenario 'display the controller source code' do
    source_code = "def "
    expect(page).to have_content(source_code)
  end

  scenario 'displays databse info' do
    expect(page).to have_content('Database Tables')
    expect(page).to have_content('USERS')
  end

end
