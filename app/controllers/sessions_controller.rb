class SessionsController < ApplicationController
skip_before_filter :verify_authenticity_token, :only => [:rpx_token] # RPX does not pass Rails form tokens...

# user_data
# found: {:name=>'John Doe', :username => 'john', :email=>'john@doe.com', :identifier=>'blug.google.com/openid/dsdfsdfs3f3'}
# not found: nil (can happen with e.g. invalid tokens)
def new
end

def rpx_token
  raise "hackers?" unless data = RPXNow.user_data(params[:token])
  self.current_user = User.find_by_identifier(data[:identifier]) || User.create!(data)
  redirect_to '/'
end

# getting additional profile fields (these fields are rarely filled)
# all possibilities: https://rpxnow.com/docs#profile_data
#data = RPXNow.user_data(params[:token], :additional => [:gender, :birthday, :photo, :providerName, ...])

# normal + raw data
#RPXNow.user_data(params[:token], :additional => [:raw_response])[:raw_response]['profile']['verifiedEmail']

# only raw data
#email = RPXNow.user_data(params[:token], :raw_response => true)['profile']['verifiedEmail']

# with extended info like friends, accessCredentials, portable contacts. (most Providers do not supply them)
#RPXNow.user_data(params[:token], :extended => true)[:extended]['friends'][...have a look at the RPX API DOCS...]
end
