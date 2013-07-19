class Attachment < ActiveRecord::Base
  attr_accessible :attach
  has_attached_file :attach, :styles => {:thumb => "120x120"}
  before_post_process :image?
  validates_attachment_content_type :attach, content_type: ['image/jpeg', 'image/png'], allow_blank: true, if: :image?
  validates :app_name, inclusion: { in: ApiKey.pluck(:app_name) }
  def image?
    !(attach_content_type =~ /^image/).nil?
  end
end
