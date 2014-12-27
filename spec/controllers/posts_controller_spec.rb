require 'rails_helper'

RSpec.describe PostsController, :type => :controller do
  render_views
  
  describe "GET index" do
    before do
      Post.create!(name: 'Setting Up Rails 4 & Angular')
      Post.create!(name: 'Testing a Rails & Angular App')
      Post.create!(name: 'New Job As a Web QA Analyst')
      Post.create!(name: 'Thanks, MakerSquare')

      xhr :get, :index, format: :json
    end

    subject(:results) { JSON.parse(response.body) }

    def extract_name
      ->(object) { object["name"] }
    end

    context "when there are posts" do
      it 'should 200' do
        expect(response.status).to eq(200)
      end

      it 'should return four results' do
        expect(results.size).to eq(4)
      end

      it "should include 'Setting Up Rails 4 & Angular'" do
        expect(results.map(&extract_name)).to include('Setting Up Rails 4 & Angular')
      end
    end
  end

  describe "GET show" do
    before do
      Post.create!(id: 1, name: 'Setting Up Rails 4 & Angular')

      get :show, id: id
    end

    subject(:results) { JSON.parse(response.body) }

    context "there is a matching postId" do
      let (:id) {1}

      it 'should 200' do
        expect(response.status).to eq(200)
      end

      its(["name"]) { should eq("Setting Up Rails 4 & Angular") }
    end

    context "there is no matching postId" do
      let (:id) {2}

      it "doesn't return an object" do
        expect(results).to_not have_key('name')
      end

      it "returns an error message" do
        expect(response.status).to eq(422)
        expect(results).to have_key('errors')
      end
    end
  end

  describe "POST create" do 
    before do
      post :create, post: { id: 1, name: name }
    end

    subject(:results) { JSON.parse(response.body) }

    context "successfully creates new post" do
      let(:name) { "Super Cool Post" }

      it "should 200" do
        expect(response.status).to eq(200)
      end

      its(["name"]) { should eq("Super Cool Post") }
    end

    context "fails to create new post" do
      let(:name) { } 

      it "errors when not given a name" do 
        expect(response.status).to eq(422)
        expect(results).to have_key('errors')
      end
    end
  end

  describe "PUT update" do
    before do
      Post.create!(name: "Rials is Cool", id: 1)
      put :update, id: 1, post: { name: name }
    end

    subject(:results) { JSON.parse(response.body) }

    context "successfully edits post" do
      let(:name) { "Rails is Cool" }

      it "should 200" do
        expect(response.status).to eq(200)
      end

      its(["name"]) { should eq("Rails is Cool") }
    end
  end

  describe "DELETE destroy" do
    before do
      Post.create!(name: 'Setting Up Rails 4 & Angular', id: 1)
      Post.create!(name: 'Testing a Rails & Angular App', id: 2)
      delete :destroy, id: id
    end

    subject(:results) { JSON.parse(response.body) }

    context "successfully deletes post" do
      let(:id) { 1 }

      it "should 200" do
        expect(response.status).to eq(200)
      end
    end

    context "unsuccessfully deletes post" do
      let(:id) { 3 }

      it "should 422" do
        expect(response.status).to eq(422)
      end
    end
  end
end