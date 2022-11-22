CarrierWave.configure do |config|
    config.fog_credentials = {
        :provider               => 'AWS',
        :aws_access_key_id      => "AKIA4GGVSOVM6TGZ534P",
        :aws_secret_access_key  => "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",
        :region                 => 'ap-northeast-1' # Change this for different AWS region. Default is 'us-east-1'
    }
    config.fog_directory  = "video-music-system"
  end