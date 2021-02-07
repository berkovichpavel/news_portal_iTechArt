require 'rails_helper'

describe StatisticsController, type: :controller do
  login_admin

  context 'GET :new' do
    subject { get :new, params: params }

    let(:params) { { user_id: current_user.id } }

    before { subject }

    it 'renders the action' do
      expect(subject).to render_template(:new)
    end

    it 'returns 200 OK' do
      expect(subject).to have_http_status(:ok)
    end
  end

  context 'POST :create' do
    subject { post :create, params: params }

    let(:params) do
      {
        user_id: current_user.id,
        statistic: {
          begin_statistic: 10.minutes.ago,
          end_statistic: 5.minutes.ago
        }
      }
    end

    it 'saves the item' do
      expect { subject }.to change(Statistic, :count).by(1)
    end

    it 'redirects to items_path' do
      expect(subject).to redirect_to user_path(current_user)
    end

    context 'with invalid params' do
      let(:params) do
        {
          user_id: current_user.id,
          statistic: {
            begin_statistic: nil,
            end_statistic: 5.minutes.ago
          }
        }
      end

      it 'does not save' do
        expect { subject }.not_to change(Statistic, :count)
      end

      it 'renders new template' do
        expect(subject).to render_template(:new)
      end
    end
  end
end
