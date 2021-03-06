class BlogpostCommentsController < ApplicationController
  respond_to :html, :atom

  def feed
    @blogpost_comments = BlogpostComment.order("created_at DESC").limit(5)

    # is that really needed?
    for comment in @blogpost_comments
      comment.blogpost.title = Blogpost.find(comment.blogpost_id).title
    end

    respond_with @blogpost_comments do |format|
      format.atom
    end
  end

  def create
    @blogpost = Blogpost.find(params[:blogpost_id])
    @blogpost_comment = @blogpost.blogpost_comments.create(params[:blogpost_comment])
    if @blogpost_comment.save
      redirect_to @blogpost
    else
      render 'blog/show'
    end
  end
end
