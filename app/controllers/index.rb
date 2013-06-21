get '/' do
  @users = User.all
  erb :index
end

get '/beer_choices' do
  @beer_choices = Beer.all
  erb :choice_form
end

post '/:user_id/likes' do |user_id|
  save_likes(params[:likes])
  find_recommendations
  redirect "/#{user_id}/recommendations"
end

get '/:user_id/recommendations' do
  beers = current_user.recommendations
  @recommendations = beers.map {|reco| [Beer.find(reco.beer_id), reco.score]}
  erb :recommendations
end

#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page
  @errors = errors 
  erb :sign_in
end

post '/sessions' do
  user = User.find_by_email(params[:email])
  if user.nil?
    session[:errors] = {username: "not found"}
    redirect '/sessions/new'
  elsif user.authenticate(params[:password]) == false
    session[:errors] = {password: "incorrect"}
    redirect '/sessions/new'    
  else
    session[:user_id] = user.id
    redirect '/'
  end
end

delete '/sessions/:id' do
  session[:user_id] = nil
end

#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  @form_data = session.delete(:form_data) if session[:form_data]
  @errors = errors 
  erb :sign_up
end

post '/users' do
  user = User.new(params[:user])
  if user.valid?
    user.save
    session[:user_id] = user.id
    redirect '/'
  else
    session[:errors] = user.errors
    session[:form_data] = convert_for_session(params[:user])
    redirect '/users/new'
  end
end
