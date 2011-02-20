require 'bundler'

Bundler.require

get '/' do
  @vol = get_volume
  haml :index
end

post '/mute' do
  set_volume 0
  redirect '/'
end

post '/max' do
  set_volume 100
  redirect '/'
end

post '/set_volume' do
  set_volume params[:vol]
  redirect '/'
end

def set_volume vol
  if vol
    `osascript -e "set volume output volume #{vol}"`
  else
    puts "Error, no volume specified"
  end
end

def get_volume
  vol = `osascript -e "output volume of (get volume settings)"`
  vol.to_i if vol
end