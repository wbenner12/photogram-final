class UsersController < ApplicationController
  skip_before_action(:authenticate_user!, { :only => [:index] }) 
  
  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :username => :asc })

    render({ :template => "users/index" })
  end
  
  def show
    the_username = params.fetch("username")
    @the_user = User.where({ :username => the_username }).first

    follow_request = FollowRequest.where(sender_id: current_user.id, recipient_id: @the_user.id).first

    if (follow_request.present? && follow_request.status == "accepted" ) || @the_user.id == current_user.id
      render({ :template => "users/show" })
    else
      redirect_to("/", { :alert => "You can't do that" })
    end
  end

  def liked_photos
    the_username = params.fetch("username")
    @the_user = User.where({ :username => the_username }).first
    render({ :template => "users/liked_photos" })
  end
  
  def feed
    the_username = params.fetch("username")
    @the_user = User.where({ :username => the_username }).first
    render({ :template => "users/feed" })
  end
  
  def discover
    the_username = params.fetch("username")
    @the_user = User.where({ :username => the_username }).first
    render({ :template => "users/discover" })
  end
end
