require 'sidekiq/api'
class CalculateViewWorker
  include Sidekiq::Worker
  sidekiq_options queue: :workers

  def perform(video_id, user_id, duration, current_time)
    video = Video.find(video_id)
    return unless video
    return unless check_time(current_time, duration)
    ActiveRecord::Base.transaction do
      History.create!(user_id: user_id, video_id: video.id, history_type: :watch, current_time: current_time, duration: duration)
      video.increment!(:views)
    end
  end

  private

  def check_time(current_time, duration)
    (duration < 60.0 && current_time == duration)  || ((60..240).include?(duration) && current_time / duration > 0.7) || (duration > 240 && current_time / duration > 0.5)
  end
end
