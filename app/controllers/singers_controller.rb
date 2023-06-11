class SingersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_singer, only: [:show, :update, :destroy, :update_avatar]
  
    # GET /singers
    def index
      @singers = Singer.all
    end
  
    # GET /singers/1
    def show
      @singer
    end
  
    # POST /singers
    def create
      @singer = Singer.new(singer_params)
  
      if @singer.save
        render json: @singer, status: :created, location: @singer
      else
        render json: @singer.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /singers/1
    def update
      if @singer.update(singer_params)
        render json: @singer
      else
        render json: @singer.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /singers/1
    def destroy
      @singer.destroy
    end
  
    def update_avatar
      if @singer.update(avatar_params)
        render json: {avatarUrl: url_for(@singer.avatar)}
      else
        render json: @singer.errors, status: :unprocessable_entity
      end  
    end

    def show_monthly_view_analytics
      views_data = History.select("count(*) as views, MONTH(histories.created_at) as month")
                          .joins("INNER JOIN videos ON histories.video_id = videos.id")
                          .where("videos.singer_id = ?", params[:id])
                          .where("histories.video_id = videos.id")
                          .where("YEAR(histories.created_at) = ?", params[:year])
                          .group("MONTH(histories.created_at)")
      render json: views_data
    end

    def show_weekly_view_analytics
      views_data = if (params[:this_week] == 'true') 
        History.select("count(*) as views, day(histories.created_at) as day, month(histories.created_at) as month")
        .joins("INNER JOIN videos ON histories.video_id = videos.id")
        .where("videos.singer_id = ?", params[:id])
        .where("histories.video_id = videos.id")
        .where("YEAR(histories.created_at) = ?", params[:year])
        .where("week(histories.created_at) = week(now())")
        .group("day(histories.created_at)")
      else 
        History.select("count(*) as views, day(histories.created_at) as day, month(histories.created_at) as month")
        .joins("INNER JOIN videos ON histories.video_id = videos.id")
        .where("videos.singer_id = ?", params[:id])
        .where("histories.video_id = videos.id")
        .where("YEAR(histories.created_at) = ?", params[:year])
        .where("week(histories.created_at) = week(now()) - 1")
        .group("day(histories.created_at)")
      end
      render json: views_data
    end
  
    def show_watched_hour_data
      watched_hour_data = History.select("sum(histories.current_time) as total, month(histories.created_at) as month")
                          .joins("INNER JOIN videos ON histories.video_id = videos.id")
                          .where("videos.singer_id = ?", params[:id])
                          .where("YEAR(histories.created_at) = ?", params[:year])
                          .where("histories.video_id = videos.id")
                          .group("month(histories.created_at)")
      render json: watched_hour_data
    end

    def show_feelings_data
      feelings_data = Feeling.select("count(case when feelings.status='1' then 1 end) as like_count, count(case when feelings.status='0' then 1 end) as dislike_count")
                          .joins("INNER JOIN videos ON feelings.video_id = videos.id")
                          .where("videos.singer_id = ?", params[:id])
                          .where("feelings.video_id = videos.id")
                          .group("year(feelings.created_at)")
      render json: feelings_data
    end

    def show_gender_data
      gender_data = User.select("sum(users.gender = 0) as male, sum(users.gender = 1) as famale")
                        .joins("INNER JOIN histories ON users.id = histories.user_id")
                        .joins("INNER JOIN videos ON histories.video_id = videos.id")
                        .where("videos.singer_id = ?", params[:id])
                        # .group("year(histories.created_at)")
                        .group("histories.user_id")
      render json: gender_data
    end

    def show_age_data
      age_data = User.select("users.age >= 10 and users.age <= 15 as from_10_to_15, 
                              users.age >= 16 and users.age <= 20 as from_16_to_20, 
                              users.age >= 21 and users.age <= 25 as from_21_to_25, 
                              users.age >= 26 and users.age <= 30 as from_26_to_30,
                              users.age >= 31 and users.age <= 35 as from_31_to_35,
                              users.age >= 36 and users.age <= 40 as from_36_to_40,
                              users.age >= 41 and users.age <= 45 as from_41_to_45,
                              users.age >= 46 and users.age <= 50 as from_46_to_50,
                              users.age >= 51 and users.age <= 55 as from_51_to_55,
                              users.age >= 56 as from_56")
                     .joins("INNER JOIN histories ON users.id = histories.user_id")
                     .joins("INNER JOIN videos ON histories.video_id = videos.id")
                     .where("videos.singer_id = ?", params[:id])
                     .group("histories.user_id")
      age_hash = {
        from_10_to_15: 0,
        from_16_to_20: 0,
        from_21_to_25: 0,
        from_26_to_30: 0,
        from_31_to_35: 0,
        from_36_to_40: 0,
        from_41_to_45: 0,
        from_46_to_50: 0,
        from_51_to_55: 0,
        from_56: 0
      }
      age_data = age_data.map do |data|
        data = data.attributes
        data.each do |key, value|
          if value.to_i != 0
            age_hash[key.to_sym] += 1
          end
        end
      end
      render json: age_hash
    end
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_singer
        @singer = Singer.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def singer_params
        params.require(:singer).permit(:email, :age, :name, :channel_name, :password, :password_confirmation)
      end
      
      def avatar_params
        params.permit(:avatar)
      end
  end
  