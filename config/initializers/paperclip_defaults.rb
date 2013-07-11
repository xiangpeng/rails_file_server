Paperclip.interpolates :year do |attachment, style_name|
  attachment.instance_read(:updated_at).in_time_zone(attachment.time_zone).year
end

Paperclip.interpolates :month do |attachment, style_name|
  attachment.instance_read(:updated_at).in_time_zone(attachment.time_zone).month
end

Paperclip.interpolates :day do |attachment, style_name|
  attachment.instance_read(:updated_at).in_time_zone(attachment.time_zone).day
end

Paperclip.interpolates :app_name do |attachment, style_name|
  attachment.instance.app_name
end
Paperclip::Attachment.default_options.update({
  :url => "/system/:app_name/:year-:month-:day/:style/:hash.:extension",
  :hash_secret => "shenyin_erp"
})
