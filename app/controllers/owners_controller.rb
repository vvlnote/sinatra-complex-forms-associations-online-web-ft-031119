class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index' 
  end

  get '/owners/new' do 
    @pets = Pet.all
    erb :'/owners/new'
  end

  post '/owners' do 
    #binding.pry
    @owner = Owner.create(params[:owner])
    if !params[:pet].empty?
      @pet = Pet.create(params[:pet])
      @owner.pets << @pet
    end
    #binding.pry
    redirect "owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do 
    #binding.pry
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    #binding.pry
    erb :'/owners/edit'
  end

  get '/owners/:id' do 
    @owner = Owner.find(params[:id])
    #binding.pry
    erb :'/owners/show'
  end

  patch '/owners/:id' do 
    #binding.pry
    if !params[:owner].keys.include?("pet_ids")
      params[:owner]["pet_ids"] = []
    end
    @owner = Owner.find_by_id(params[:id])
    #binding.pry
    @owner.update(params[:owner])
    if !params[:pet][:name].empty?
      pet = Pet.create(:name => params[:pet][:name])
      @owner.pets << pet
    end
    #binding.pry
    redirect "/owners/#{@owner.id}"
  end
  
end