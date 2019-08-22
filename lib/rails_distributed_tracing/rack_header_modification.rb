require 'rails_distributed_tracing/distributed_tracing'

class RackHeaderModification
  def initialize(app)
    @app = app
  end

  def call(env)

    @status, @headers, @response = @app.call(env)
    Rails.logger.info('********************************************************')

    @headers[DistributedTracing::TRACE_ID] = DistributedTracing.trace_id

    Rails.logger.info(@headers)

    [@status, @headers, @response]
  end
end
