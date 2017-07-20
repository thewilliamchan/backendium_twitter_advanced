class Tweet < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :message, presence: true, length: { maximum: 140 }

  has_attached_file :image,
                    :storage => :s3,
                    :s3_credentials => Proc.new{|a| a.instance.s3_credentials }

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def s3_credentials
    {
      :bucket => ENV['PHOTO_UPLOAD_BUCKET'],
      :access_key_id => ENV['AWS_S3_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_S3_SECRET_ACCESS_KEY'],
      :s3_region => "us-east-1"
    }
  end
end
