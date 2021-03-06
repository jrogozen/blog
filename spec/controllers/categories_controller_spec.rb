require 'rails_helper'

RSpec.describe CategoriesController, :type => :controller do
  render_views

  before(:each) do
    mock_controller_headers
  end

  describe "GET index" do
    before do
      Category.create!(name: 'Javascript', id: 1)
      Category.create!(name: 'Ruby', id: 2)

      Post.create!(name: "Learn JS", category_id: 1)
      Post.create!(name: "JS Tricks!", category_id: 1)
      get :index
    end

    subject(:results) { JSON.parse(response.body) }

    context "when there are categories" do
      it "should 200" do
        expect(response.status).to eq(200)
      end

      it "should return 2 results" do
        expect(results.size).to eq(2)
      end

      it "should include 'Javascript'" do
        expect(results.first["name"]).to eq("Javascript")
      end

      it "includes all posts in Category" do 
        expect(results.first["posts"].size).to eq(2)
        expect(results.first["posts"].first["name"]).to eq("Learn JS")
      end
    end
  end

  describe "GET show" do
    before do
      Category.create!(name: 'Ruby', id: 1)

      get :show, id: id
    end

    subject(:results) { JSON.parse(response.body) }

    context "when there is a matching category" do
      let(:id) {1}

      it "should 200" do
        expect(response.status).to eq(200)
      end

      its(["name"]) { should eq("Ruby") }
    end

    context "when there is no matching category" do
      let(:id) {2}

      it "should 422" do
        expect(response.status).to eq(422)
      end

      it "should provide an error message" do
        expect(results).to have_key('errors')
      end

      it 'should not have the name key' do
        expect(results).not_to have_key('name')
      end
    end
  end

  describe "POST create" do
    before do
      post :create, category: {id: 1, name: name}
    end

    subject(:results) { JSON.parse(response.body) }

    context "successfully creates a new category" do
      let(:name) {'ruby'}

      it "should 200" do
        expect(response.status).to eq(200)
      end

      it "capitalizes the category" do
        expect(results["name"]).to eq("Ruby")
      end
    end
  end

  describe "POST create duplicate check" do
    before do
      Category.create!(name: 'Ruby')

      post :create, category: {name: 'Ruby'}
    end

    subject(:results) { JSON.parse(response.body) }

    context "does not create a duplicate category" do
      it "should 422" do
        expect(response.status).to eq(422)
      end

      it "returns duplicate error" do
        expect(results["errors"].first).to eq("Name has already been taken")
      end
    end
  end

  describe "DELETE destroy" do
    before do
      Category.create!(name: 'Ruby', id: 1)

      delete :destroy, id: id
    end

    subject(:results) { JSON.parse(response.body) }

    context "deletes the category" do
      let(:id) { 1 }

      it "should 200" do
        expect(response.status).to eq(200)
      end
    end

    context "category doesn't exist" do
      let(:id) { 2 }

      it "should 422" do
        expect(response.status).to eq(422)
        expect(results["errors"].first).to eq("Category does not exist")
      end
    end
  end
end
