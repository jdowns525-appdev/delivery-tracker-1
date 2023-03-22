# == Schema Information
#
# Table name: deliveries
#
#  id            :integer          not null, primary key
#  delivery_date :date
#  description   :string
#  detail        :string
#  status        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#
class Delivery < ApplicationRecord
  #belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id" })
end
