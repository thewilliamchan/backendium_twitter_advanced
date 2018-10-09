class Tweet < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :message, presence: true, length: { maximum: 140 }

  # has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"

  has_attached_file :image, :storage => :s3, :s3_credentials => Proc.new{|a| a.instance.s3_credentials }

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def s3_credentials
    {:bucket => "lession-twitter-photo-upload-williamchan", :access_key_id => "AKIAI3Z7TEDD6PXRWUDQ", :secret_access_key => "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", :s3_region => "ap-northeast-1", :s3_host_name => "s3-ap-northeast-1.amazonaws.com"}
  end
end
