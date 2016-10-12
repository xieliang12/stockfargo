class Research < ActiveRecord::Base
  belongs_to :favorite
  belongs_to :user

  has_attached_file :attach,
    styles: lambda { |a| a.instance.attach_content_type.index("image/") == 0 ? { :small => "200x", :original => "600x", :large => "900x" } : {} }
  do_not_validate_attachment_file_type :attach
end

##|attachment| attachment.instance.attach_content_type.index("image/") == 0
##validates_attachment_content_type :attach, :content_type => "image/jpg"
##validates_attachment_file_name :attach, matches: [/png\z/, /jpe?g\z/, /gif\z/, /pdf\z/, /txt\z/, /rtf\z/ ]
