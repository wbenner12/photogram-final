class UsersController < ApplicationController
  skip_before_action(:authenticate_user!, { :only => [:index] }) 
  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :username => :asc })

    @user = @list_of_users.at(0)

    render({ :template => "users/index" })
  end
  def show
    @username = params.fetch("username")
    @the_user = User.where(username: @username).first

    matching_users = User.where({ :id => @the_user.id })

    @user = matching_users.at(0)

    matching_follow_requests = FollowRequest.where({ :sender_id => current_user.id, :recipient_id => @user.id })
    the_follow_request = matching_follow_requests.at(0)

    @followrequest = the_follow_request.present?

    if @the_user == nil
      redirect_to("/404")
    else
      render(template: "users/show")
    end
  end
end
