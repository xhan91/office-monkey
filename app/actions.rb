enable :sessions
helpers do 

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user ? true : false
  end

end

# Gets the main page of Office Monkey (Critique Wall)
require 'chartkick'
get '/' do
  session[:user_id] = 2
  @has_title = false
  @critiques = Critique.all.order(created_at: :desc).limit(10)
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
  @has_title = false
  @user = User.find(params[:user_id])
  @most_recent_critique = @user.critiques.order(created_at: :desc).first

  case params[:filter_criteria]
  when "subject"
      @user_critiques = @user.critiques.order(:subject_id)
  when "ripe_reviews"
      @user_critiques = @user.critiques.where(is_ripe_banana: true).order(created_at: :desc)
  when "rotten_reviews"
      @user_critiques = @user.critiques.where(is_ripe_banana: false).order(created_at: :desc)
  when "recently_posted"
      @user_critiques = @user.critiques.order(created_at: :desc)
  else
      @user_critiques = @user.critiques.order(created_at: :desc)
  end

  params.delete(:filter_criteria)
  erb :'/users/show_profile'
end

###### CRITIQUE WALL ###########

# Posts a new critique to the Critique Wall
post '/critiques' do
  user = User.find params[:user_id]
  subject = Subject.find params[:subject_id]
  is_ripe_banana = (params[:banana] == "true")
  content = params[:content]
  critique = Critique.create(
    user: user,
    subject: subject,
    is_ripe_banana: is_ripe_banana,
    content: content)
  if request.xhr?
    erb :_critique_wall, layout: false, locals: { critique: critique, new_post: true }
  else
    redirect '/'
  end
end

# Search for critiques
get '/critiques/search' do
  result = Critique.all
  if params[:subject_id] != "all"
    result = result.where(subject_id: params[:subject_id])
  end
  search = "%#{params[:search_string]}%"
  @critiques = result.where("content LIKE ?", search).order(created_at: :desc)
  erb :main
end

# Deletes a critique from the Critique Wall
delete '/critiques/:critique_id' do
  critique = Critique.find params[:critique_id]
  user_id = critique.user_id
  critique.destroy

  redirect "/users/#{user_id}"
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

get '/report' do
  @has_title = true
	erb :'report/show_report'
end

get '/report/:id' do
  @subject = Subject.find params[:id]
  @subject_id = params[:id]
  erb :'report/report_details'
end