# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base
  has_many :types
  has_many :items, :through => :types

  # scope :tops, where(:name =>'Tops')

  def self.top # name it singluar if you're after a single record
    where(:name => 'Tops').first
  end

  TOP = Category.where(:name => 'Tops').first
end

# Category::TOP
#instance_eval
# define_method
# class_eval