class Tweet < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :message, presence: true, length: { maximum: 140 }

  # has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"

  has_attached_file :image, :storage => :s3, :s3_credentials => Proc.new{|a| a.instance.s3_credentials }

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def s3_credentials
    {:bucket => ENV['PHOTO_UPLOAD_BUCKET'], :access_key_id => ENV['AWS_S3_ACCESS_KEY_ID'], :secret_access_key => ENV['AWS_S3_SECRET_ACCESS_KEY'], :s3_region => "ap-northeast-1", :s3_host_name => "s3-ap-northeast-1.amazonaws.com"}
  end
end
