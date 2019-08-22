require 'rails_distributed_tracing/distributed_tracing'

class RackHeaderModification
  def initialize(app)
    @app = app
  end

  def call(env)

    @status, @headers, @response = @app.call(env)
    Rails.logger.info('********************************************************')

    # @response.headers[DistributedTracing::TRACE_ID] = DistributedTracing.trace_id

    Rails.logger.info(@headers.merge(asdf: 1))

    [@status, @headers, @response]
  end
end
