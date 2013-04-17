class PagesController < ApplicationController
  def home
  end

  def welcome
  end

  def testpage
	
		#render :text => params[:token]
		token = params[:token]
		
		rpx = Rpx::RpxHelper.new('17a9dced3acb1171dfb1322435f7b65bdab74eb1', 'https://rpxnow.com', 'se-assessment-project-eric-nelson')
		
		authdata = rpx.auth_info(token)
		
		render :text => authdata
  end
end
