require 'rails_helper'

describe ItemsController, type: :controller do
  login_admin

  let(:items) { create_list :item, 5 }
  let(:item) { create :item }
  let(:item_params) do
    {
      item: {
        title: Faker::Lorem.paragraph_by_chars(number: 90),
        short_description: Faker::Lorem.paragraph_by_chars(number: 100),
        full_text: Faker::Lorem.paragraph(sentence_count: 20..45),
        mask: 'visible',
        status: 'active',
        category: 'auto'
      }
    }
  end

  context 'GET :index' do
    before { get :index }

    it 'renders the action' do
      expect(response).to render_template(:index)
    end

    it 'return trust values' do
      expect(assigns(:items)).to match_array(items)
      expect(assigns(:other_items)).to match_array(items)
      expect(assigns(:important_items)).to match_array([])
    end
  end

  context 'GET :show' do
    before { get :show, params: { id: item.id } }

    it 'renders the action' do
      expect(response).to render_template :show
    end

    it 'returns trust values' do
      expect(assigns(:redactor)).to eq(User.find(item.author_id).nickname)
    end
  end

  context 'POST :create' do
    subject { post :create, params: item_params }

    it 'saves the item' do
      expect { subject }.to change(Item, :count).by(1)
    end

    it 'redirect to items_path' do
      is_expected.to redirect_to item_path(assigns(:item).id)
    end

    context 'with invalid params' do
      let(:item_params) do
        { item:  { title: 'Title' } }
      end

      it 'does not save' do
        expect { subject }.to_not change(Item, :count)
      end

      it 'render new template' do
        is_expected.to render_template :new
      end
    end
  end

  context 'POST :update' do
    subject { put :update, params: params }
    let(:params) do
      {
        id: item.id,
        item: { category: 'news' }
      }
    end

    it 'should update item' do
      expect { subject }.to change { item.reload.category }.from('auto').to('news')
    end

    it 'redirect to items_path' do
      is_expected.to redirect_to item_path(assigns(:item).id)
    end

    context 'with invalid params' do
      let(:params) do
        {
          id: item.id,
          item: {
            short_description: 'lol'
          }
        }
      end

      it 'does not update' do
        expect { subject }.not_to change{ item.reload.category }
      end

      it 'render new template' do
        is_expected.to render_template :edit
      end
    end
  end

  context 'DELETE :delete' do
    subject { delete :destroy, params: params }
    let(:params) { { id: item.id } }
    before { item }

    it 'deletes from Item' do
      expect { subject }.to change(Item, :count).by(-1)
    end

    it 'redirects to items_path' do
      is_expected.to redirect_to items_path
    end
  end

  context 'POST :track' do
    let(:item_view) { create(:item_view, user_id: current_user.id, watching_time: 120) }
    let(:item) { item_view.item }
    subject { post :track, params: params }
    let(:params) { { id: item.id } }

    it 'increments watching time' do
      expect { subject }.to change { item_view.reload.watching_time }.from(120).to(220)
    end
  end
end
