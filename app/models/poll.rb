class Poll < ActiveRecord::Base
  validates_presence_of :question
  has_many :answers, :dependent => :destroy
  has_many :voters, :dependent => :destroy
  accepts_nested_attributes_for :answers, :reject_if => lambda { |a| a[:answer].blank? }, :allow_destroy => true
end
