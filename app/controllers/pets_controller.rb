class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    #binding.pry
    @pet = Pet.new(:name => params["pet_name"])
    if params["owner_id"] != nil && !params["owner_id"].empty?
      @pet.owner = Owner.find(params["owner_id"])
    end
    if params["owner_name"] != nil && params["owner_name"] != ""
      owner = Owner.new(:name => params["owner_name"])
      owner.save
      @pet.owner = owner
    end
    @pet.save
    #binding.pry
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 

    redirect to "pets/#{@pet.id}"
  end
end