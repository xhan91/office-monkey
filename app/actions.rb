# Gets the main page of Office Monkey (Critique Wall)
get '/' do
  erb :main
end

# Automatically set the session's user
# Clicking the login button will trigger this action
post '/sessions' do
  # Redirect to main page
end

###### USER PROFILE ###########

# Gets a user's profile page
get '/users/:user_id' do

end

###### CRITIQUE WALL ###########

# Gets a page which enables a user to post to the critique wall
get '/critques/new' do

end

# Posts a new critique to the Critique Wall
post '/critiques' do

end

# Deletes a critique from the Critique Wall
delete '/critiques/:critique_id' do

end

# Adds a new upvote to the critque
post '/upvotes/:critique_id/new' do
  # Redirect to main page
end

###### ANALYSIS PAGE ###########

# Gets the analysis page for all user critiques
get '/analysis' do

end