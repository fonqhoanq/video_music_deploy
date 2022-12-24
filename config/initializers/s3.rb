CarrierWave.configure do |config|
    config.fog_credentials = {
        :provider               => '',
        :aws_access_key_id      => "",
        :aws_secret_access_key  => "",
        :region                 => '' # Change this for different AWS region. Default is 'us-east-1'
    }
    config.fog_directory  = "video-music-system"
  end