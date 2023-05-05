# frozen_string_literal: true
require 'sidekiq/api'
class UploadVideoWorker
  include Sidekiq::Worker
  sidekiq_options queue: :workers

  def perform(video_id)
    video = Video.find(video_id)
    return unless video
    return unless video.uploaded_video_at.blank?
    ActiveRecord::Base.transaction do
      video.update!(uploaded_video_at: Time.current, video_status: :is_public)
      handle_send_notification(video, video.title)
    end
  end

  class << self
    def scheduled_job(video_id)
      scheduled = Sidekiq::ScheduledSet.new
      scheduled.select { |job| job.klass == name.to_s && job.args.first == video_id }
               .last
    end

    def delete_job(video_id)
      scheduled = Sidekiq::ScheduledSet.new
      jobs = scheduled.select { |job| job.klass == name.to_s && job.args.first == video_id }
      jobs.each(&:delete)
    end
  end

  private

  def target_members_to_sent_notification(video)
    singer = video.singer
    target_members = User.joins("INNER JOIN subscribes ON subscribes.user_id = users.id")
                         .where("subscribes.singer_id = #{singer.id}")
                         .where("subscribes.status = 1")
  end

  def handle_send_notification(video, title)
    target_members_to_sent_notification(video).each do |member|
      MemberNotification.create!(video_id: video.id,
                                 content: "Recent upload video: #{title}",
                                 user_id: member.id,
                                 noti_status: :sent,
                                 noti_type: :recent_upload_video_notification
                                )
    end
  end
end
