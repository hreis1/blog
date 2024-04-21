class CreatePostsFromTextJob
  include Sidekiq::Job

  def perform(text, user_id)
    Post.create_from_text(text, user_id)
  end
end
