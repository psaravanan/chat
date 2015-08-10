class Message < ActiveRecord::Base
	belongs_to :user, class_name: "User", foreign_key: :from_id
end
