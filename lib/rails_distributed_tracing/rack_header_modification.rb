require 'rails_distributed_tracing/distributed_tracing'

class RackHeaderModification
  def initialize(app)
    @app = app
  end

  def call(env)

    @status, @headers, @response = @app.call(env)

    @headers[DistributedTracing::TRACE_ID] = DistributedTracing.trace_id

    [@status, @headers, @response]
  end
end