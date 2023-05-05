# frozen_string_literal: true

class VideoService
  attr_reader :video

  def initialize(video)
    @video = video
  end

  def schedule(schedule_at)
    return scheduled.reschedule(schedule_at) if scheduled
    UploadVideoWorker.perform_at(schedule_at, video.id)
  end

  def delete_message_survey
    UploadVideoWorker.delete_job(video.id)
  end

  def scheduled_at
    scheduled&.at
  end

  private

  def scheduled
    UploadVideoWorker.scheduled_job(video.id)
  end
end
