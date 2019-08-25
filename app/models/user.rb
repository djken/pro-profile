class User < ApplicationRecord
    has_one :profile
    has_secure_password
    has_secure_token :confirmation_token

    # validates :username, 
    # format: {with: /\A[a-zA-Z0-9_]{2,20}\z/, message: 'Must contained only alphanumerical characters or _'},
    # uniqueness: {case_sensitive: false}

    validates :email, 
    format: {with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/, message: 'E-mail is invalid'},
    uniqueness: {case_sensitive: false}


    def to_session
        {id: id}
    end
end