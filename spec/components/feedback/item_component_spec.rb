# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Feedback::ItemComponent, type: :component do
  let(:user) { create(:user) }

  context 'when the user is the author' do
    let(:draft_feedback) { create(:feedback, author: user) }
    let(:complete_feedback) { create(:feedback, author: user, status: :completed) }

    it "renders with the text 'For'" do
      render_inline(described_class.new(feedback: draft_feedback, current_user: user))

      expect(page).to have_content('For')
    end

    it 'renders an edit link' do
      render_inline(described_class.new(feedback: draft_feedback, current_user: user))

      expect(page).to have_link('Edit')
    end

    it "renders 'Awaiting completion' with incomplete feedback" do
      render_inline(described_class.new(feedback: draft_feedback, current_user: user))

      expect(page).to have_content('Awaiting completion')
    end
  end

  context 'when the user is the receiver' do
    let(:draft_feedback) { create(:feedback, receiver: user) }
    let(:complete_feedback) { create(:feedback, receiver: user, status: :completed) }

    it 'renders nothing with a draft feedback' do
      render_inline(described_class.new(feedback: draft_feedback, current_user: user))

      expect(page).not_to have_selector('body')
    end

    it "renders with the text 'From' with completed feedback" do
      render_inline(described_class.new(feedback: complete_feedback, current_user: user))

      expect(page).to have_content('From')
    end

    it 'does not render an edit link with completed feedback' do
      render_inline(described_class.new(feedback: complete_feedback, current_user: user))

      expect(page).not_to have_button('Edit')
    end
  end

  context 'when the feedback references a Pair Request' do
    let(:feedback) { create(:feedback, referenceable: create(:pair_request), author: user) }

    it "renders a 'Pair Programming Feedback' heading" do
      render_inline(described_class.new(feedback:, current_user: user))

      expect(page).to have_content('Pair Programming Feedback')
    end
  end

  context 'when the feedback references a User' do
    let(:feedback) { create(:feedback, referenceable: create(:user), author: user) }

    it "renders a 'User Feedback' heading" do
      render_inline(described_class.new(feedback:, current_user: user))

      expect(page).to have_content('User Feedback')
    end
  end
end
