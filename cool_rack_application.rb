require "rack"
require 'rack/handler/puma'

class CoolRackApplication
  def call(env)
    http_verb = env["REQUEST_METHOD"]
    status = 200
    headers = {}
    body = ["got #{http_verb} request\n"]

    [status, headers, body]
  end
end

class PatchBlockingMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)

    if request.patch?
      [405, {}, ['PATCH requests are not allowed!\n']]
    else
      @app.call(env)
    end
  end
end

app = Rack::Builder.new do
  use PatchBlockingMiddleware
  run CoolRackApplication.new
end

# Run on localhost, port 9292
Rack::Handler::Puma.run(app, Port: 9292)
