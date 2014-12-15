require 'rails_helper'

RSpec.describe "layouts/application.html.erb", :type => :view do
  describe "Nav bar" do
    context 'for authenticated user' do
      before do
        allow(view).to receive(:user_signed_in?).and_return(true)
        render
      end

      it 'has a logout link' do
        expect(rendered).to have_selector("a[href='#{destroy_user_session_path}']")
        expect(rendered).to_not have_selector("a[href='#{new_user_session_path}']")
      end

      it 'has a edit user link' do
        expect(rendered).to have_selector("a[href='#{edit_user_registration_path}']")
        expect(rendered).to_not have_selector("a[href='#{new_user_registration_path}']")
      end
    end

    context 'for non authenticated user' do
      before do
        render
      end

      it 'has a login link' do
        expect(rendered).to have_selector("a[href='#{new_user_session_path}']")
        expect(rendered).to_not have_selector("a[href='#{destroy_user_session_path}']")
      end

      it 'has a register user link' do
        expect(rendered).to have_selector("a[href='#{new_user_registration_path}']")
        expect(rendered).to_not have_selector("a[href='#{edit_user_registration_path}']")
      end
    end    
  end
end