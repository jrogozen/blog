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

      it 'returns object with name key' do
        expect(results).to have_key('name')
      end
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
end