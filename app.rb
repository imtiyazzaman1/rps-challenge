require './lib/game'
require './lib/player'
require 'sinatra/base'

class RPS < Sinatra::Base
  enable :sessions

  get '/' do
    erb(:index)
  end

  get '/one_player_sign_in' do
    erb(:one_player_sign_in)
  end

  post '/name' do
    @game = Game.create(player_1: params[:player_name])
    redirect to '/play'
  end

  get '/play' do
    @game = Game.instance
    erb(:play)
  end

  get '/lose' do
    @game = Game.instance
    erb(:lose)
  end

  get '/draw' do
    @game = Game.instance
    erb(:draw)
  end

  get '/win' do
    @game = Game.instance
    erb(:win)
  end

  post '/choose_rock' do
    @game = Game.instance
    @game.player_1.choose_rock
    @game.player_2.choose_random
    redirect to '/lose' if @game.player_2.move == "Paper"
    redirect to '/draw' if @game.player_2.move == "Rock"
    redirect to '/win' if @game.player_2.move == "Scissors"
  end

  post '/choose_paper' do
    @game = Game.instance
    @game.player_1.choose_paper
    @game.player_2.choose_random
    redirect to '/lose' if @game.player_2.move == "Scissors"
    redirect to '/draw' if @game.player_2.move == "Paper"
    redirect to '/win' if @game.player_2.move == "Rock"
  end

  post '/choose_scissors' do
    @game = Game.instance
    @game.player_1.choose_scissors
    @game.player_2.choose_random
    redirect to '/lose' if @game.player_2.move == "Rock"
    redirect to '/draw' if @game.player_2.move == "Scissors"
    redirect to '/win' if @game.player_2.move == "Paper"
  end

  run! if app_file == $0
end
