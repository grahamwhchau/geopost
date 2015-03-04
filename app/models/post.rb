class Post < ActiveRecord::Base #.all, .find(1) comes from here
	has_many :comments


	validates :title, presence: true, uniqueness: true
	validates :body, {length: {minimum: 100, maxmimum: 5000}}
end
