class UsersController < ApplicationController
   
  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :username => :asc })

    @user = @list_of_users.at(0)

    render({ :template => "users/index" })
  end
  def show
    @username = params.fetch("username")
    @the_user = User.where(username: @username).first

    if @the_user == nil
      redirect_to("/404")
    else
      render(template: "users/show")
    end
  end
end
