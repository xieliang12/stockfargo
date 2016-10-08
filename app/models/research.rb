class Research < ActiveRecord::Base
  belongs_to :favorite
  belongs_to :user

  has_attached_file :attach
  validates_attachment_content_type :attach, :content_type => ["image/jpg", "image/gif", "image/png", "application/pdf", "text/plain"]
  #validates_attachment_file_name :attach, matches: [/png\z/, /jpe?g\z/, /gif\z/, /pdf\z/, /txt\z/, /rtf\z/ ]
end
