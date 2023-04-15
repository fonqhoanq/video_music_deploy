class HashTagsController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET /HashTags
  def index
    @hash_tags = HashTag.all
  end
end
