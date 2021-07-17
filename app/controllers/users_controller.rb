class UsersController < ApplicationController
  skip_forgery_protection

  def index
    respond_with(User.where(arena: params[:arena]))
  end

  def create
    if User.where(username: params[:username], arena: params[:arena]).exists?
      return respond_with_error("User already exists.", 40)
    end

    user = User.create!(username: params[:username], rating: 1000, arena: params[:arena])
    respond_with(user)
  end

  def post_result
    if params[:user1].blank? || params[:user2].blank?
      return respond_with_error("users missing", 40)
    elsif params[:arena].blank?
      return respond_with_error("arena missing", 41)
    end

    user1 = User.where(username: params[:user1], arena: params[:arena]).first
    user2 = User.where(username: params[:user2], arena: params[:arena]).first
    if user1.blank? || user2.blank?
      return respond_with_error("Users not found", 42)
    end

    change = expected_change(user1.rating, user2.rating)
    user1.update!(rating: user1.rating + change)
    user2.update!(rating: user2.rating - change)
    respond_with({})
  end

  private

  def expected_change(rating1, rating2)
    expected_score = 1 / (1 + 10 ** ((rating2 - rating1).to_f / 400))
    (20 * (1 - expected_score)).ceil
  end
end
