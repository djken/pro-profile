class User < ApplicationRecord
    attr_accessor :avatar_file

    has_one :profile
    has_one_attached :image
    
    has_secure_password
    has_secure_token :confirmation_token

    after_save :avatar_after_upload
    before_save :avatar_before_upload
    after_destroy_commit :avatar_destroy

    validates :username, 
    format: {with: /\A[a-zA-Z0-9_]{2,20}\z/, message: 'Must contained only alphanumerical characters or _'},
    uniqueness: {case_sensitive: false}

    validates :email, 
    format: {with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/, message: 'E-mail is invalid'},
    uniqueness: {case_sensitive: false} 

    validates :avatar_file, file: {ext: [:jpg, :png]}

    def to_session
        {id: id}
    end
    

    def avatar_path
        File.join(
            Rails.public_path, 
            self.class.name.downcase.pluralize,
            id.to_s,
            'avatar.jpg'
            )
    end

    def avatar_url
       '/' + [
            self.class.name.downcase.pluralize,
            id.to_s,
            'avatar.jpg'
        ].join('/')
    end

    private
    def avatar_before_upload
        if avatar_file.respond_to? :path
            self.avatar = true
        end
    end

    def avatar_after_upload
        path = avatar_path
            if avatar_file.respond_to? :path
                dir = File.dirname(path)
                FileUtils.mkdir_p(dir) unless Dir.exist?(dir)
                # FileUtils.cp(avatar_file.path, path)
                image = MiniMagick::Image.new(avatar_file.path) do |b|
                    b.resize "150x150"
                    b.gravity 'center'
                    b.crop '150x150+0+0'
                end
                image.format 'jpg'
                image.write path
            end
    end

    def destroy
        dir = File.dirname(avatar_path)
        FileUtils.rm_r(dir) if Dir.exist?(dir)
    end
end