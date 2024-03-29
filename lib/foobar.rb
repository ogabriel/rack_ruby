# frozen_string_literal: true

require 'erb'

class Foobar
  def call(env)
    request = Rack::Request.new(env)

    case request.path
    when '/' then Rack::Response.new(render('index.html.erb'))
    else Rack::Response.new('Not found', 404)
    end
    # Rack::Response.new(render('index.html.erb'))
    # [200, {'Content-Type' => 'text/plain'}, ["Hello rack world"]]
  end

  def render(template)
    path = File.expand_path("../views/#{template}", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end
end
