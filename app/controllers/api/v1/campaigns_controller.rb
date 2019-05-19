 class Api::V1::CampaignsController < ApplicationController
  before_action :find_campaign, only: [:show, :update, :destroy]

  skip_before_action :authorized, only: [:create, :update, :index, :show]

  def index
    if (params["limit"]) || (!!request.headers["HTTP_REFERRER"] && request.headers["HTTP_REFERER"].split(//).last(6).join == "browse")
      campaigns = Campaign.all.select {|campaign| campaign.successful == false}
      @campaigns = campaigns.slice(params["offset"].to_i, params["offset"].to_i + params["limit"].to_i)
      render :index
      return
    end
  	@campaigns = Campaign.all
  	render :index
  end

  def show
  	render json: @campaign
  end

  def create
    byebug
  	@campaign = Campaign.create(campaign_params)
  	if @campaign.valid?
  	  render json: @campaign, status: :created
  	else
  	  render json: { errors: @campaign.errors.full_messages }, status: :unprocessible_entity
  	end
  end

  def update
    @campaign.update(campaign_params)
    if @campaign.valid?
      render json: @campaign
    else
      render json: { errors: @campaign.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def destroy
    @campaign.destroy
  end

  private

  def campaign_params
  	params.require(:campaign).permit(:title, :description, :goal, :user_id, :photo, :successful)
  end

  def find_campaign
  	@campaign = Campaign.find(params[:id])
  end
end
