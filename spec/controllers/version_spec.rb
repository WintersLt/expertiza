require 'rails_helper'
include LogInHelper

describe VersionsController do

  context "user not logged in" do
	it "should not be able to create new version" do
	  get :new
	  expect(response).should redirect_to(request.env['HTTP_REFERER'] ? :back : :root)
	end

	it "should not be able to edit a version" do
	  get :edit, { id: 1 }
	  expect(response).should redirect_to(request.env['HTTP_REFERER'] ? :back : :root)
	end
  end


  context "logged in as student" do
    before(:each) do
      #setup fake login
      student.save
      @user = User.find_by_name("student")
      @role = double("role", :super_admin? => false)
      ApplicationController.any_instance.stub(:current_user).and_return(@user)
      ApplicationController.any_instance.stub(:current_role_name).and_return('Student')
      ApplicationController.any_instance.stub(:current_role).and_return(@role)
	end

    it "should not allow student to call destroy_all versions" do
      delete :destroy_all
      expect(response).should redirect_to(request.env['HTTP_REFERER'] ? :back : :root)
    end

	it "should not be able to create new version" do
	  get :new
	  expect(response).should redirect_to(request.env['HTTP_REFERER'] ? :back : :root)
	end

	it "should not be able to edit a version" do
	  get :edit, { id: 1 }
	  expect(response).should redirect_to(request.env['HTTP_REFERER'] ? :back : :root)
	end
  end

  context "logged in as administrator" do
    before(:each) do
      #setup fake login
      @user = double("admin", :timezonepref => "Eastern Time (US & Canada)")
      @role = double("role", :super_admin? => false)
      ApplicationController.any_instance.stub(:current_user).and_return(@user)
      ApplicationController.any_instance.stub(:current_role_name).and_return('Administrator')
      ApplicationController.any_instance.stub(:current_role).and_return(@role)
	end

    it "should allow admin to call destroy_all versions" do
      delete :destroy_all
	  expect(response).should redirect_to versions_path
    end

	it "should not be able to create new version" do
	  get :new
	  expect(response).should redirect_to(request.env['HTTP_REFERER'] ? :back : :root)
	end

	it "should not be able to edit a version" do
	  get :edit, { id: 1 }
	  expect(response).should redirect_to(request.env['HTTP_REFERER'] ? :back : :root)
	end
  end

end
