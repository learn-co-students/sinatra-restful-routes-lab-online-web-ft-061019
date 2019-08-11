
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!

  get '/' do
    redirect '/recipes'
  end 

  get '/recipes' do 
    @recipes = Recipe.all 
    erb :index
  end 

#renders form to create new_recipe 
  get '/recipes/new' do 
    erb :new
  end 

  post '/recipes' do
    @recipe = Recipe.create(name: params["name"], ingredients: params["ingredients"], cook_time: params["cook_time"])
    redirect "/recipes/#{@recipe.id}"
  end 
#end
#action that will display single recipe 
  get '/recipes/:id' do 
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end 
#end
#action to edit single recipe 
  get '/recipes/:id/edit' do 
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end 

  patch '/recipes/:id' do 
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect "/recipes/#{@recipe.id}"
  end 
#end 
#action to delete recipe 
  delete '/recipes/:id' do 
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect '/recipes'
  end 
end
#end 