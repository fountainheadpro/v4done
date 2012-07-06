require 'rubygems'
require 'fog'
require 'base64'

class ActionUrlController  < ApplicationController
  respond_to :json
  before_filter :init_agent

  def create
    body=params["data"]
    type=params["type"]
    key=params["key"]

    # create a connection
    connection = Fog::Storage.new({
      :provider               => 'AWS',       # required
      :aws_access_key_id      => 'AKIAIPDC44JXGOMU2RBQ',       # required
      :aws_secret_access_key  => '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',       # required
      :region                 => 'us-east-1'  # optional, defaults to 'us-east-1'
    })

    directory = connection.directories.get('actionsimages')

    file=directory.files.create(
      :content_type=> type,
      :body =>  StringIO.new(Base64.decode64(body.gsub(/^data:image\/(png|jpg);base64,/, ""))),
      :key=> key,
      :public => true,
      :storage_class=>'REDUCED_REDUNDANCY'
    )

    render :json => {:success => true, :type=>'link', :title => file.public_url}
  end

  def show
    url=params[:url]
    url='http://'+url unless url.starts_with?('http://')
    begin
      page = @agent.get(url)
      if page.response['content-type'] =~ /image/i
        render :json => {:success => true, :type=>'image', :url => url}
      end
      if page.response['content-type'] =~ /text/i
        render :json => {:success => true, :type=>'link', :title => page.title}
      end
    rescue
      render :json => {:success => false, :type=>'error', :url => url}
    end
  end

  private

  def init_agent
    unless @agent
      @agent = Mechanize.new
      @agent.user_agent_alias = 'Mac Safari'
    end
  end

end