class LikesController < ApplicationController
  def index
    matching_likes = Like.all

    @list_of_likes = matching_likes.order({ :created_at => :desc })

    render({ :template => "likes/index" })
  end

  def show
    matching_photo = Photo.where({ :id => params.fetch("path_id") })
    @the_photo = matching_photo.at(0)

    matching_likes = Like.where({ :fan_id => current_user.id, :photo_id => @the_photo.id })
    the_like = matching_likes.at(0)

    if the_like.nil?
      @liked = false
    else
      @liked = true
    end

    render({ :template => "photos/show" })
  end

  def create
    the_like = Like.new
    the_like.fan_id = current_user.id
    the_like.photo_id = params.fetch("query_photo_id")

    if the_like.valid?
      the_like.save
      redirect_to("/photos/" + the_like.photo_id.to_s, { :notice => "Like created successfully." })
    else
      redirect_to("/photos/" + the_like.photo_id.to_s, { :alert => the_like.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_like = Like.where({ :id => the_id }).at(0)

    the_like.fan_id = params.fetch("query_fan_id")
    the_like.photo_id = params.fetch("query_photo_id")

    if the_like.valid?
      the_like.save
      redirect_to("/likes/#{the_like.id}", { :notice => "Like updated successfully."} )
    else
      redirect_to("/likes/#{the_like.id}", { :alert => the_like.errors.full_messages.to_sentence })
    end
  end

  def destroy
    
    matching_likes = Like.where({ :fan_id => current_user.id, :photo_id => params.fetch("query_photo_id") })
    @the_like = matching_likes.at(0)
    
    if @the_like.nil?
      redirect_to("/photos/" + params.fetch("query_photo_id"), { :alert => "Like not found." })
    else
      @the_like.destroy
      redirect_to("/photos/" + params.fetch("query_photo_id"), { :notice => "Like deleted successfully." })
    end
  end
end
