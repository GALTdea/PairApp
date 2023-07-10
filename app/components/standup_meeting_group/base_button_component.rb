# frozen_string_literal: true

class StandupMeetingGroup::BaseButtonComponent < ViewComponent::Base
  # the .for method is a factory method that will return the correct component
  # based on the current user's relationship with the standup_meeting_group
  def self.for(standup_meeting_group:, current_user:)
    standup_meeting_group_user = standup_meeting_group.standup_meeting_group_user(current_user.id)

    klass_name = standup_meeting_group_user.present? ? 'LeaveButtonComponent' : 'JoinButtonComponent'

    "StandupMeetingGroup::#{klass_name}".safe_constantize.new(standup_meeting_group:, current_user:,
      standup_meeting_group_user:)
  end
  # this method returns the correct component based on the current user's relationship with the standup_meeting_group
  # example if the current user is a member of the standup_meeting_group, then the LeaveButtonComponent will be returned
  # if the current user is not a member of the standup_meeting_group, then the JoinButtonComponent will be returned
  # the .safe_constantize method is a rails method that will return nil if the constant does not exist
  # the .new method is a ruby method that will create a new instance of the class

  # the .for method is a factory method that will return the correct component
  # based on the current user's relationship with the standup_meeting_group

  # say that we call StandupMeetingGroup::JoinButtonComponent.new(standup_meeting_group: standup_meeting_group, current_user: current_user)
  # and the current_user is not a member of the standup_meeting_group
  # then the .for method will return StandupMeetingGroup::JoinButtonComponent.new(standup_meeting_group: standup_meeting_group, current_user: current_user)


  def self.for(standup_meeting_group:, current_user:)
    standup_meeting_group_user = standup_meeting_group.standup_meeting_group_user(current_user.id)

    klass_name = standup_meeting_group_user.present? ? 'LeaveButtonComponent' : 'JoinButtonComponent'

    "StandupMeetingGroup::#{klass_name}".safe_constantize.new(standup_meeting_group:, current_user:,
      standup_meeting_group_user:)
  end
  # this method returns the correct component based on the current user's relationship with the standup_meeting_group
  # example if the current user is a member of the standup_meeting_group, then the LeaveButtonComponent will be returned
  # if the current user is not a member of the standup_meeting_group, then the JoinButtonComponent will be returned
  # the .safe_constantize method is a rails method that will return nil if the constant does not exist
  # the .new method is a ruby method that will create a new instance of the class

  # the .for method is a factory method that will return the correct component
  # based on the current user's relationship with the standup_meeting_group
  def self.for(standup_meeting_group:, current_user:)
    standup_meeting_group_user = standup_meeting_group.standup_meeting_group_user(current_user.id)

    klass_name = standup_meeting_group_user.present? ? 'LeaveButtonComponent' : 'JoinButtonComponent'

    "StandupMeetingGroup::#{klass_name}".safe_constantize.new(standup_meeting_group:, current_user:,
      standup_meeting_group_user:)
  end
  # this method returns the correct component based on the current user's relationship with the standup_meeting

  protected

  attr_reader :standup_meeting_group, :user
  # the initialize method is a ruby method that will be called when a new instance of the class is created
  # the argument standup_meeting_group: is a named argument that will be passed in when the new instance of the class is created
  def initialize(standup_meeting_group:, current_user:, **args)
    @standup_meeting_group = standup_meeting_group
    @user = current_user

    after_initialize(**args)
  end

  def after_initialize(**); end
end
