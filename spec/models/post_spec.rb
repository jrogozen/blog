require "rails_helper"

RSpec.describe Post, :type => :model do

  describe Post do
    context "with no blurb" do
      it "creates blurb based on content" do
        post = Post.create!(name: "My Post", content: "This is such a cool post, omg.")
        post.create_blurb
        expect(post.reload.blurb).to eq("This is such a cool post, omg.")
      end

      it "trims content to 140 characters" do
        post = Post.create!(name: "My Long Post", content: "Cupcake ipsum dolor. Sit amet apple pie gummi bears carrot cake marzipan. Dragée liquorice gummi bears powder halvah. Sesame snaps cheesecake jelly beans danish chocolate bar applicake candy candy tiramisu. Pudding gingerbread donut caramels donut pastry. Jelly lollipop biscuit bonbon chocolate cake halvah.")
        post.create_blurb
        expect(post.reload.blurb.size).to eq(140)
      end
    end

    context "with blurb" do
      it "uses supplied blurb" do
        post = Post.create!(name: "My Blurbed Post", content: "This is a great post", blurb: "This is a great blurb")
        post.create_blurb
        expect(post.reload.blurb).to eq("This is a great blurb")
      end
    end

    context "with no blurb or content" do
      it "keeps both fields empty" do
        post = Post.create!(name: "What you want?")
        expect(post.blurb).to be_nil
        expect(post.content).to be_nil
      end
    end
  end

end