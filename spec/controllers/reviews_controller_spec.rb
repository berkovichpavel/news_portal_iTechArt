require 'rails_helper'

describe ReviewsController, type: :controller do
  login_admin

  let(:item) { create(:item) }

  context 'GET :new' do
    subject { get :new, params: params }

    let(:params) { { item_id: item.id } }

    before { subject }

    it 'renders the action' do
      expect(subject).to render_template(:new)
    end

    it 'returns 200 OK' do
      expect(subject).to have_http_status(:ok)
    end
  end

  context 'GET :edit' do
    subject { get :edit, params: params }

    let!(:review) { create(:review, rating: 5) }
    let(:params) { { id: review.id, item_id: item.id } }

    before { subject }

    it 'renders the action' do
      expect(subject).to render_template(:edit)
    end

    it 'returns 200 OK' do
      expect(subject).to have_http_status(:ok)
    end
  end

  context 'POST :create' do
    subject { post :create, params: params }

    let(:params) do
      {
        item_id: item.id,
        review:
          {
            rating: '3',
            comment: 'lol'
          }
      }
    end

    it 'saves the item' do
      expect { subject }.to change(Review, :count).by(1)
    end

    it 'redirects to items_path' do
      expect(subject).to redirect_to item_path(item)
    end

    context 'with invalid params' do
      let(:params) do
        {
          item_id: item.id,
          review:
            {
              rating: nil,
              comment: 'lol'
            }
        }
      end

      it 'does not save' do
        expect { subject }.not_to change(Review, :count)
      end

      it 'renders new template' do
        expect(subject).to render_template(:new)
      end
    end
  end

  context 'POST :update' do
    subject { put :update, params: params }

    let!(:review) { create(:review, rating: 5) }
    let(:params) do
      {
        id: review.id,
        item_id: item.id,
        review:
          {
            rating: 2
          }
      }
    end

    it 'updates item' do
      expect { subject }.to change { review.reload.rating }.from(5).to(2)
    end

    it 'redirects to items_path' do
      expect(subject).to redirect_to item_path(item)
    end

    context 'with invalid params' do
      let(:params) do
        {
          id: review.id,
          item_id: item.id,
          review:
            {
              rating: nil
            }
        }
      end

      it 'does not update' do
        expect { subject }.not_to change { review.reload.rating }.from(5)
      end

      it 'renders new template' do
        expect(subject).to render_template(:edit)
      end
    end
  end

  context 'DELETE :delete' do
    subject { delete :destroy, params: params }

    let!(:review) { create(:review, user: current_user, item: item) }
    let(:params) { { item_id: item.id, id: review.id } }

    it 'deletes from RssSubscription' do
      expect { subject }.to change(Review, :count).by(-1)
    end

    it 'redirects to items_path' do
      expect(subject).to redirect_to item_path(item)
    end
  end
end
