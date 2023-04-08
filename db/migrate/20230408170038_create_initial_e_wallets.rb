class CreateInitialEWallets < ActiveRecord::Migration[7.0]
  def up
    User.all.each do |user|
      Currency.all.each do |currency|
        EWallet.create(user: user, currency: currency)
      end
    end
  end

  def down
    EWallet.delete_all
  end
end
