class LibraryController < ApplicationController
  get '/library' do
    user_logged_in
    user = authenticate
    @games = user.games if user.games

    erb :'library/index'
  end

  get '/library/:id/add' do
    user = authenticate
    game = Game.find_by_id(params[:id])

    if !user
      @errors = { 'Auth' => ['Error authenticating user'] }
      erb :failure
    elsif !game
      @errors = { 'Games' => ['Game not found'] }
    end

    user.games << game unless user.games.find_by_id(game.id)

    redirect '/games'
  end

  get '/library/:id/remove' do
    user = authenticate
    game = Game.find_by_id(params[:id])

    if !user.email
      @errors = { 'Auth' => ['Error authenticating user'] }
      erb :failure
    elsif !game
      @errors = { 'Games' => ['Game not found'] }
    end

    user.games.delete(game) if user.games&.find_by_id(game.id)

    if params[:location] && params[:location] == 'library'
      redirect '/library'
    else
      redirect '/games'
    end
  end
end
