class StandupMeetingGroup::LeaveButtonComponent < StandupMeetingGroup::BaseButtonComponent
  
  
  def after_initialize(standup_meeting_group_user:)
    @standup_meeting_group_user = standup_meeting_group_user
    
  end

  private

  attr_reader :standup_meeting_group_user
  # the standup_meeting_group_user is a join table between the standup_meeting_group and the user , so it is a join model
  # to pass this join model to the component, we need to pass it as an argument to the .new method like this:
  # StandupMeetingGroup::LeaveButtonComponent.new(standup_meeting_group: standup_meeting_group, current_user: current_user, standup_meeting_group_user: standup_meeting_group_user)
  # the standup_meeting_group_user variable is an instance variable that is set in the after_initialize method like this:
  # 
end
