describe UsersController, type: :controller do
  describe 'GET :index' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user, role: 'correspondent') }
    before { get :index }

    it 'assigns @users' do
      expect(assigns(:users)).to eq([user1, user2])
    end

    it 'assigns @users with role correspondent' do
      get :index, params: { role: 'correspondent' }
      expect(assigns(:users)).to eq([user2])
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end

    context 'returns a 200 OK' do
      it { is_expected.to respond_with :ok }
    end
  end

  describe 'GET :show' do
    let(:user) { create(:user) }

    it 'renders the action' do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
      expect(response).to render_template(:show)
    end
  end
end
