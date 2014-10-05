class Budget < ActiveRecord::Base
  has_many :rounds, dependent: :destroy
  has_one  :latest_round, class_name: 'Round', order: "id DESC"
  has_many :allocators, dependent: :destroy

  def current_round_id
    current_round = rounds.last
    current_round.id if current_round
  end
end