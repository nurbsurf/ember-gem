require 'rake-pipeline'
require 'rake-pipeline/middleware'

assetfile = File.expand_path('../Assetfile', __FILE__)
use Rake::Pipeline::Middleware, Rake::Pipeline::Project.new(assetfile)

# require 'rack/streaming_proxy'
# use Rack::StreamingProxy do |request|
#    if request.path.start_with?('/proxy')
#      path = request.path
#      if request.query_string
#        path = "#{path}?#{request.query_string}"
#      end
#      "http://127.0.0.1:8080#{path}"
#    end
# end

require 'rack-rewrite'
use Rack::Rewrite do
  rewrite %r{^(.*)\/$}, '$1/index.html'
end

run Rack::Directory.new('assets')
