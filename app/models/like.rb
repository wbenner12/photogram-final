# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fan_id     :integer
#  photo_id   :integer
#
class Like < ApplicationRecord
  validates :fan_id, presence: true
  validates :photo_id, presence: true
  validates :photo_id, uniqueness: { scope: ["fan_id"], message: "already liked" }

  
  belongs_to :user, required: true, class_name: "User", foreign_key: "fan_id"
  
  belongs_to :photo, required: true, class_name: "Photo", foreign_key: "photo_id", counter_cache: true


end
