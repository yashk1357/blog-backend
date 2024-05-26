class AccountsController < ApplicationController
  def signup
    account = Account.new(account_params)
    if account.save
      token = AuthService.encode_token({ id: account.id })
      render json: { message: 'Account created successfully', data: {
                                                                    account: account, token: token
                                                                  } }, 
             status: :created
    else
      render json: { error: account.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    account = Account.find_by(email: params[:email])
    if account && account.authenticate(params[:password])
      token = AuthService.encode_token({ id: account.id })
      render json: { data: {account: account, token: token} }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def top_creators
    top_acc = Account
      .left_joins(:posts)
      .select('accounts.*, COUNT(posts.id) AS posts_count')
      .group(:id)
      .order('posts_count DESC')
      .limit(10)

    render json: top_acc, status: :ok
  end



  private

  def account_params
    params.permit(:full_name, :email, :password)
  end
end
