enable :sessions

helpers do 

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end

# Gets the main page of Office Monkey (Critique Wall)
get '/' do
  session[:user_id] = 2
  erb :main
end

# Automatically set the session's user
# Clicking the login button will trigger this action
post '/sessions' do
  session[:user_id] = User.find(2).id
  redirect '/'
end

###### USER PROFILE ###########

# Gets a user's profile page
get '/users/:user_id' do
  @user = User.find(2)
  erb :'/users/show_profile'
end

###### CRITIQUE WALL ###########

# Gets a page which enables a user to post to the critique wall
get '/critiques/new' do

end

# Posts a new critique to the Critique Wall
post '/critiques' do
  user = User.find params[:user_id]
  subject = Subject.find params[:subject_id]
  is_ripe_banana = (params[:banana] == "true")
  content = params[:content]
  if critique = Critique.create(
    user: user,
    subject: subject,
    is_ripe_banana: is_ripe_banana,
    content: content)
    session[:flash] = "Post a new feedback successfully!"
    redirect '/'
  else
    session[:flash] = critique.errors.full_messages
    redirect '/'
  end
end

# Deletes a critique from the Critique Wall
delete '/critiques/:critique_id' do

end

# Adds a new upvote to the critique
# post '/upvotes/:critique_id/new' do
post '/votes' do
  # Redirect to main page
  user = User.find params[:user_id]
  critique = Critique.find params[:critique_id]
  if vote = Vote.where(user: user).where(critique: critique).first
    vote.destroy
  else
    Vote.create(user: user, critique: critique)
  end
  "#{critique.votes.count}"
end

###### ANALYSIS PAGE ###########

# Gets the analysis page for all user critiques
get '/analysis' do

end