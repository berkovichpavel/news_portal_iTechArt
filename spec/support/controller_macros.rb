module ControllerMacros
  def login_admin
    let(:current_user) { FactoryBot.create(:user) }
    before(:each) do |example|
      unless example.metadata[:skip_before]
        @request.env['devise.mapping'] = Devise.mappings[:admin]
        sign_in current_user
      end
    end
  end
end
