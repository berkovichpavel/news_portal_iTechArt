require 'rails_helper'

describe RssSubscriptionsController, type: :controller do
  login_admin

  let(:subscription) { create(:rss_subscription) }

  context 'GET :index' do
    subject { get :index }

    before do
      subscription
      subject
    end

    it 'renders the action' do
      expect(subject).to render_template(:index)
    end

    it 'returns 200 OK' do
      expect(subject).to have_http_status(:ok)
    end

    it 'returns trust values' do
      expect(assigns(:rss_subscriptions).to_a).to match_array([subscription])
    end
  end

  context 'GET :new' do
    subject { get :new }

    before { subject }

    it 'renders the action' do
      expect(subject).to render_template(:new)
    end

    it 'returns 200 OK' do
      expect(subject).to have_http_status(:ok)
    end

    it 'returns trust values' do
      expect(assigns(:categories).to_a).to match_array(RssSubscription.categories)
    end
  end

  context 'POST :create' do
    subject { post :create, params: params }

    let(:params) do
      {
        rss_subscription:
          {
            reference_link: 'https://news.tut.by/rss/auto.rss',
            category: 'auto'
          }
      }
    end

    it 'saves the item' do
      expect { subject }.to change(RssSubscription, :count).by(1)
    end

    it 'redirects to items_path' do
      expect(subject).to redirect_to rss_subscriptions_path
    end

    context 'with invalid params' do
      let(:params) do
        {
          rss_subscription:
            {
              reference_link: nil,
              category: 'auto'
            }
        }
      end

      it 'does not save' do
        expect { subject }.not_to change(RssSubscription, :count)
      end

      it 'renders new template' do
        expect(subject).to render_template(:new)
      end
    end
  end

  context 'DELETE :delete' do
    subject { delete :destroy, params: params }

    let(:params) { { id: subscription.id } }

    before { subscription }

    it 'deletes from RssSubscription' do
      expect { subject }.to change(RssSubscription, :count).by(-1)
    end

    it 'redirects to items_path' do
      expect(subject).to redirect_to rss_subscriptions_path
    end
  end
end
