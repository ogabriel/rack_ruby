# frozen_string_literal: true

require 'foobar'

use Rack::Reloader, 5

run Foobar.new
