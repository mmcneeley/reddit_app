class VotesController < ApplicationController
  before_action :authorized?, only: [:up, :down]

  def up
    get_vote
    if @current_vote
      @current_vote.destroy
    end
    @vote = Vote.create(post_id: params[:post_id], user_id: current_user.id, value: 1)
    redirect_to posts_path
  end

  def down
    get_vote
    if @current_vote
      @current_vote.destroy
    end
    @vote = Vote.create(post_id: params[:post_id], user_id: current_user.id, value: -1)
    redirect_to posts_path
  end

  private

  def get_vote
    @current_vote = Vote.find_by(post_id: params[:post_id], user_id: current_user.id)
  end

end
