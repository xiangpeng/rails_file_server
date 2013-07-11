class Attachment < ActiveRecord::Base
  attr_accessible :attach
  has_attached_file :attach, :styles => {:thumb => "120x120"}
  validates_attachment_content_type :attach, content_type: ['image/jpeg', 'image/png'], allow_blank: true
  validates :app_name, inclusion: { in: ApiKey.pluck(:app_name) }
end
