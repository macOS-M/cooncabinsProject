class CabinView < ApplicationRecord
  belongs_to :user, optional:true
  belongs_to :cabin


end
