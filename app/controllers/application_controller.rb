
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    erb :new
  end
  
  get '/articles/:id' do
    @article = Article.all.find{|a| a.id.to_s == params[:id]}
    if @article
      erb :show
    else
      redirect '/articles'
    end
  end  
  
  post '/articles' do
    @article = Article.create({:title => params[:article][":title"], :content => params[:article][":content"]})
    redirect "/articles/#{Article.last.id}"
  end
  
  get '/articles/:id/edit' do
    @article = Article.all.find{|a| a.id.to_s == params[:id]}
    
    erb :edit
  end

  patch '/articles/:id' do
    article = Article.all.find{|a| a.id.to_s == params[:id]}
    article[:title] = params[:article][":title"]
    article[:content] = params[:article][":content"]
    article.save
    @article = article
    erb :show
  end


  delete '/articles/:id' do
    article = Article.all.find{|a| a.id.to_s == params[:id]}
    article.delete
    erb :index
  end


end
