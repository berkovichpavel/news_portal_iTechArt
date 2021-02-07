require 'rails_helper'

describe UsersController, type: :controller do
  login_admin

  context 'GET :index' do
    subject { get :index, params: { role: 'admin' } }

    before { subject }

    it 'renders the action' do
      expect(subject).to render_template(:index)
    end

    it 'returns 200 OK' do
      expect(subject).to have_http_status(:ok)
    end

    it 'returns trust values' do
      expect(assigns(:users).to_a).to eq([current_user])
    end

    context 'when returns all users' do
      subject { get :index }

      let!(:user) { create(:user, role: 'correspondent') }

      it 'returns trust values' do
        expect(assigns(:users).to_a).to eq([current_user, user])
      end
    end
  end

  context 'GET :comments_activity' do
    before { get :comments_activity, params: { id: current_user.id } }

    let!(:comment) { create(:comment, user: current_user) }

    it 'renders the action' do
      expect(response).to render_template(:comments_activity)
    end

    it 'returns 200 OK' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns trust values' do
      expect(assigns(:comments).to_a).to eq([comment])
    end
  end

  context 'GET :items_activity' do
    let!(:item_view) { create(:item_view, user_id: current_user.id) }

    before { get :items_activity, params: { id: current_user.id } }

    it 'renders the action' do
      expect(response).to render_template(:items_activity)
    end

    it 'returns 200 OK' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns trust values' do
      expect(assigns(:items).to_a).to eq([item_view.item])
    end
  end

  context 'POST :update' do
    subject { put :update, params: params }

    let(:params) do
      {
        id: current_user.id,
        user: {
          role: 'correspondent'
        }
      }
    end

    it 'updates item' do
      expect { subject }.to change { current_user.reload.role }.from('admin').to('correspondent')
    end

    it 'redirects to user_path' do
      expect(subject).to redirect_to user_path(current_user.id)
    end

    context 'with invalid params' do
      let(:params) do
        {
          id: current_user.id,
          user: {
            role: ''
          }
        }
      end

      it 'does not update' do
        expect { subject }.not_to change { current_user.reload.role }.from('admin')
      end

      it 'renders new template' do
        expect(subject).to render_template(:edit)
      end
    end
  end
end
