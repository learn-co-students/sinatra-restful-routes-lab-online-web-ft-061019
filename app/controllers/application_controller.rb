class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @recipe = Recipe.create(params)
    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do
    fetch_recipe #gives me @recipe from the :id passed in.
    erb :show
  end

  delete '/recipes/:id' do
    fetch_recipe
    @recipe.destroy
    redirect '/recipes'
  end

  get '/recipes/:id/edit' do
    fetch_recipe
    erb :edit
  end

  patch '/recipes/:id' do
    fetch_recipe
    @recipe.update_all
    redirect "/recipes/#{@recipe.id}"
  end

  

  private
  helpers
  def fetch_recipe
    @recipe = Recipe.find_by_id(params[:id])
  end

end
