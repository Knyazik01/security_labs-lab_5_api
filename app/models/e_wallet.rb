class EWallet < ApplicationRecord
  belongs_to :user
  belongs_to :currency

  before_save :set_defaults

  def set_defaults
    self.count ||= 0
  end
end
