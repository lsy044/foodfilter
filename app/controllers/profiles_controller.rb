class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy,:myposts]
  before_action :authorize_admin, only: [:index]
  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    # puts "====================="
    # puts "profile"
    # puts @profile.id
    # puts current_user.id
    # params[:id] = current_user.id
    # @user_requests = Userrequest.where(uid: current_user.id)
    @conversations = Conversation.all
  
    #작성글
    @user_posts = Freeboard.where(user: @profile.user).where.not(category:"제보글").order("created_at desc").limit(5)

    # 댓글단 게시글
    @user_comments_id =  Comment.where(user_id:@profile.user).pluck(:commentable_id)
    @user_comments = Freeboard.where(id:@user_comments_id).where.not(user:@profile.user).order("created_at desc").limit(5)
    # 제보글
    @user_requests = Freeboard.where(:user_id => @profile.user.id, :category => '제보글').order("created_at desc")
    # @requests_array = Kaminari.paginate_array(@user_requests).page(params[:page]).per(3)
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
    @profile.user = current_user
    @profile.save!
    
    redirect_to profile_path(@profile.id)
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def myposts
    @profile = Profile.find(params[:id])    
     #작성글
     @user_posts = Freeboard.where(user_id: @profile.user_id).where.not(category:"제보글").order("created_at desc")
  end

  def myrequests
    @profile = Profile.find(params[:id])    
     # 제보글
     @user_requests = Freeboard.where(user: @profile.user, :category => '제보글').order("created_at desc")      
  end

  def mycomments
    @profile = Profile.find(params[:id])    
     # 댓글단 게시글
     @user_comments_id =  Comment.where(user:@profile.user).pluck(:commentable_id) #내가 댓글단게시글의 id
     @user_comments = Freeboard.where(id:@user_comments_id).where.not(user:@profile.user).order("created_at desc")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:user_id)
    end
end
