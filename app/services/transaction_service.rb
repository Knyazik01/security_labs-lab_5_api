class TransactionService
  def self.create(user, currency, profit: 0, bill: 0)
    e_wallet = EWallet.find_by(user: user, currency: currency)

    is_success = false

    unless e_wallet.nil?
      balance_before = e_wallet.count
      balance = balance_before + profit.truncate(2) - bill.truncate(2)

      if balance >= 0
        # create transaction
        transaction = Transaction.new(
          user: user,
          currency: currency,
          balance_before: balance_before.truncate(2),
          profit: profit.truncate(2),
          bill: bill.truncate(2),
          balance: balance.truncate(2)
        )

        # update user e-wallet
        e_wallet.update(count: balance.truncate(2))

        # save the changes
        is_ewallet_saved = e_wallet.save
        is_transaction_saved = transaction.save

        # set is transaction success to true
        is_success = is_transaction_saved && is_ewallet_saved
      end
    end

    # return
    is_success
  end

  def self.rollback(user, currency, profit: 0, bill: 0, with_transaction: false)
    # for rollback we change profit to bill and bill to profit
    e_wallet = EWallet.find_by(user: user, currency: currency)

    is_success = false

    unless e_wallet.nil?
      balance_before = e_wallet.count
      balance = balance_before + bill.truncate(2) - profit.truncate(2)

      if balance >= 0
        is_transaction_saved = !with_transaction
        # create transaction
        if with_transaction
          transaction = Transaction.new(
            user: user,
            currency: currency,
            balance_before: balance_before.truncate(2),
            profit: bill.truncate(2),
            bill: profit.truncate(2),
            balance: balance.truncate(2)
          )

          is_transaction_saved = transaction.save
        end

        # update user e-wallet
        e_wallet.update(count: balance)

        # save the changes
        is_ewallet_saved = e_wallet.save

        # set is transaction success to true
        is_success = is_transaction_saved && is_ewallet_saved
      end
    end

    # return
    is_success
  end
end