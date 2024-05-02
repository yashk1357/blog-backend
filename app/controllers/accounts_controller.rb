class AccountsController < ApplicationController
  def signup
    account = Account.new(account_params)
    if account.save
      token = AuthService.encode_token({ id: account.id })
      render json: { message: 'Account created successfully', token: token }, status: :created
    else
      render json: { error: account.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    account = Account.find_by(email: params[:email])
    if account && account.authenticate(params[:password])
      token = AuthService.encode_token({ id: account.id })
      render json: { token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def account_params
    params.permit(:full_name, :email, :password)
  end
end
