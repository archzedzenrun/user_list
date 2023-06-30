require "sinatra"
require "sinatra/reloader" if development?
require "tilt/erubis"
require "yaml"

before do
  @users = YAML.load_file("./data/users.yml").sort.to_h
end

helpers do
  def count_users
    @users.size
  end

  def count_interests
    @users.map { |_, value| value[:interests].size }.sum
  end
end

get "/" do
  @title = "User list"
  @use = params[:use]
  erb :home
end

get "/users/:name" do
  @name = params[:name]
  @title = @name
  @info = @users[@name.to_sym]
  erb :user
end

not_found do
  redirect "/"
end