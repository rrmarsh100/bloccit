require 'rails_helper'

RSpec.describe SponsoredPostsController, type: :controller do

  let(:my_sponsored_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:my_sponsored_post) { my_sponsored_topic.sponsored_posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_number) }

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { topic_id: my_sponsored_topic.id, id: my_sponsored_post.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, params: { topic_id: my_sponsored_topic.id, id: my_sponsored_post.id }
      expect(response).to render_template :show
    end

    it "assigns my_sponsored_post to @sponsored_post" do
      get :show, params: { topic_id: my_sponsored_topic.id, id: my_sponsored_post.id }
      expect(assigns(:sponsored_post)).to eq(my_sponsored_post)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, params: { topic_id: my_sponsored_topic.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new, params: { topic_id: my_sponsored_topic.id }
      expect(response).to render_template :new
    end

    it "initializes @sponsored_post" do
      get :new, params: { topic_id: my_sponsored_topic.id }
      expect(assigns(:sponsored_post)).not_to be_nil
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: { topic_id: my_sponsored_topic.id, id: my_sponsored_post.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, params: { topic_id: my_sponsored_topic.id, id: my_sponsored_post.id }
      expect(response).to render_template :edit
    end

    it "assigns sponsored post to be updated to @sponsored_post" do
      get :edit, params: { topic_id: my_sponsored_topic.id, id: my_sponsored_post.id }
      post_instance = assigns(:sponsored_post)

      expect(post_instance.title).to eq my_sponsored_post.title
      expect(post_instance.body).to eq my_sponsored_post.body
      expect(post_instance.price).to eq my_sponsored_post.price
    end
  end

end
