class AuthService

    def self.encode_token(payload)
        JWT.encode(payload, ENV["SECRET_KEY"], 'HS256')
    end

    def self.decode_token(token)
      begin
        decoded_token = JWT.decode(token, ENV["SECRET_KEY"], algorithm: 'HS256')
        return decoded_token.first
      rescue JWT::DecodeError
        return nil
      end
    end
  end