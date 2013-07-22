module AttachmentService
  class API < Grape::API
    format :json
    default_format :json

    helpers do
      def authenticate!
        error!('401 Unauthorized', 401) unless (params[:access_token] && params[:app_name] && ApiKey.find_by_app_name(params[:app_name]).try(:access_token)==params[:access_token])
      end
    end
    before do
      authenticate! unless request.get?
    end


    desc 'get current time'
    get :attachment_count do
      {attachment_count: Attachment.count}
    end

    # RestClient.post('http://127.0.0.1:4000/attachments/api/img_upload',
    # {:attach => File.new("/Users/xiangpeng/Pictures/3004502.png", 'rb'),
    # :content_type => 'image/png',
    # :original_filename => 'DSC03935.JPG',
    # :app_name => 'shenyin_erp',
    # :access_token => 'f431a2279ebc2f5b9f901c7ba304057e'})
    desc 'upload a image file'
    params do
      requires :content_type, type: String, desc: "Content-Type."
    end
    post :img_upload do
      puts params
      begin
        @attachment = Attachment.new
        upload_file = ActionDispatch::Http::UploadedFile.new(params[:attach])
        upload_file.content_type = params[:content_type]
        upload_file.original_filename = params[:original_filename]
        @attachment.attach = upload_file
        @attachment.app_name = params[:app_name]
        @attachment.table_name = params[:table_name]
        @attachment.table_id = params[:table_id]
        @attachment.save!
        {status: 'OK', id: @attachment.id, url: @attachment.attach.url, thumb_url: @attachment.attach.url(:thumb), original_filename: @attachment.attach_file_name.to_s}
      rescue Exception => e
        puts "****************   " + e.message + "   ****************"
        {status: 'ERROR', message: e.message}
      end
    end

    desc 'get a file url'
    params do
      requires :id, type: Integer, desc: 'id in table attachments'
    end
    post :get_url do
      attachment = Attachment.where(id: params[:id], app_name: params[:app_name]).first
      if attachment
        {status: 'OK', id: params[:id], url: attachment.attach.url} 
      else
        {status: 'ERROR', message: 'not found'}
      end
    end


    # RestClient.post('http://127.0.0.1:4000/attachments/api/file_delete', {:id => 1281, :access_token => 'f431a2279ebc2f5b9f901c7ba304057e', :app_name => 'shenyin_erp'})
    desc 'delete a file'
    params do
      requires :id, type: Integer, desc: "attachment id"
    end
    post :file_delete do
      unless params[:app_name] == Attachment.find_by_id(params[:id]).try(:app_name)
        {error: '401 Unauthorized'}
      else
        Attachment.find(params[:id]).destroy
      end
    end


  end
end