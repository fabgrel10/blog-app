require 'rails_helper'

RSpec.describe User, type: :model do
  before :all do
    @author = User.create(name: 'Test User', photo: 'https://example.com/test.jpg', bio: 'I am a test user ',
                          posts_counter: 0)

    Post.create(author: @author, title: 'post A', text: 'text A', comments_counter: 0,
                likes_counter: 0)
    Post.create(author: @author, title: 'post B', text: 'text B', comments_counter: 0,
                likes_counter: 0)
    Post.create(author: @author, title: 'post C', text: 'text C', comments_counter: 0,
                likes_counter: 0)
  end

  context 'user creation' do
    it 'validates presence of name' do
      @author.name = nil
      expect(@author).to_not be_valid
    end

    it 'validates name length less than 50' do
      @author.name = 'a' * 51
      expect(@author).to_not be_valid
    end

    it 'bio and photo can be blank' do
      @author.name = 'Fabrizio'
      @author.bio = ''
      @author.photo = ''
      expect(@author).to be_valid
    end
  end

  context '.posts_counter' do
    it 'validates presence' do
      @author.posts_counter = nil
      expect(@author).to_not be_valid
    end

    it 'validates posts_counter greater than or equal to zero' do
      @author.posts_counter = nil
      expect(@author).to_not be_valid
    end
  end

  context '.most_recent_posts' do
    it 'should get the 3 most recent posts' do
      expect(@author.recent_posts.length).to eq 3
    end

    it 'should get the last post as the first result' do
      expect(@author.recent_posts.first.title).to eq 'post C'
    end

    it 'should get the third post as the last result' do
      expect(@author.recent_posts.last.title).to eq 'post A'
    end
  end
end
