require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
  render_views

  before(:each) do
    mock_controller_headers
  end

  describe "GET index" do
    before do
      Post.create!(name: "Learn JS", category_id: 1, id: 1)
      Comment.create!(content: "My first comment.", post_id: 1, user_id: 1)
      Comment.create!(content: "My second comment.", post_id: 1, user_id: 1)
      get :index, post_id: 1
    end

    subject(:results) { JSON.parse(response.body) }

    context "when a post has comments" do
      it "should 200" do
        expect(response.status).to eq(200)
      end

      it "should return 2 results" do
        expect(results.size).to eq(2)
      end

      it "should include 'My first comment'" do
        expect(results.first["content"]).to eq("My first comment.")
      end

      it "includes the correct user" do
        expect(results.first["user_id"]).to eq(1)
      end

      it "includes user's name" do
        expect(results.first["user_name"]).to eq("Jon Rogozen")
      end
    end
  end

  describe "DELETE destroy" do
    before do
      Comment.create!(content: "My first comment.", post_id: 1, user_id: 1, id: 1)
      delete :destroy, post_id: 1, id: id
    end

    subject(:results) { JSON.parse(response.body) }

    context "when comment exists" do
      let(:id) { 1 }

      it "should 200" do
        expect(response.status).to eq(200)
      end
    end

    context "when comment doesn't exist" do
      let(:id) { 3 }

      it "should 422" do
        expect(response.status).to eq(422)
      end
    end
  end

  describe "POST create" do
    before do
      Post.create!(name: "Learn JS", category_id: 1, id: 1)
      post :create, post_id: post_id, comment: {content: "My first comment", post_id: post_id}
    end

    subject(:results) { JSON.parse(response.body) }

    context "successfully create comment" do
      let(:post_id) { 1 }

      it "should 200" do
        expect(response.status).to eq(200)
      end

      it "should set the correct user" do
        expect(results["user_id"]).to eq(1)
      end

      it "should attach to the correct post" do
        expect(results["post_id"]).to eq(1)
      end

      it "should have the correct content" do
        expect(results["content"]).to eq("My first comment")
      end
    end

    context "doesn't create the comment" do
      let(:post_id) { 10 }

      it "should 422" do
        expect(response.status).to eq(422)
      end

      it "should error with no post found" do
        expect(results["errors"].first).to eq("Post does not exist")
      end
    end
  end

end
