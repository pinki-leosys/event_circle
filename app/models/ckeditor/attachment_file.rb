require 'video_controller.rb'
class Ckeditor::AttachmentFile < Ckeditor::Asset
  mount_uploader :data, CkeditorAttachmentFileUploader, :mount_on => :data_file_name
    attr_accessible :data

  def url_thumb
    @url_thumb ||= Ckeditor::Utils.filethumb(filename)
  end
  	include ControllerVideoProcessor
  after_save { |record| 
    	thumbnail(record.url,2,record.id, record.data_file_name)
    }
end
