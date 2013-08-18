module SignInHelpers
  def sign_in
    sign_in_as '12Torn-F1-5544-22'
  end
  
  def sign_in_as image_nr
    visit store_path
    fill_in 'image_nr', with: image_nr
    click_button 'Logga in'
  end
  
end

RSpec.configure do |config|
  config.include SignInHelpers
end