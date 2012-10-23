module ResourcesHelper
  def resource_name
     :user
      end

      def resource
        @devise_resource ||= User.new
      end

      def devise_mapping
        @devise_mapping ||= Devise.mappings[:user]
      end
      #Borrowed from Stack Overflow 
      #http://stackoverflow.com/questions/5909121/converting-a-regular-youtube-link-into-an-embedded-video
      def youtube_embed(youtube_url)
        if youtube_url[/youtu\.com\/([^\?]*)/]
          youtube_id = $1
        else
          # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
          youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
          youtube_id = $5
        end

        %Q{<iframe title="YouTube video player" width="640" height="390" src="http://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe>}
      end
end
