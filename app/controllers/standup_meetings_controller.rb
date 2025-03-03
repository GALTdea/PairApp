class StandupMeetingsController < ApplicationController
  def index
    @meeting_date = params[:date].nil? ? Date.current : Date.parse(params[:date])
    @standup_meeting_group = StandupMeetingGroup.includes(:users)
                                                .find(params[:standup_meeting_group_id])
    authorize @standup_meeting_group, policy_class: StandupMeetingPolicy
    @standup_meetings = @standup_meeting_group.standup_meetings
                                              .includes(:user)
                                              .where(meeting_date: @meeting_date)
  end

  def edit
    @standup_meeting = StandupMeeting.includes(:standup_meeting_group).find(params[:id])
    @standup_meeting_group = @standup_meeting.standup_meeting_group
    authorize @standup_meeting
  end
end
