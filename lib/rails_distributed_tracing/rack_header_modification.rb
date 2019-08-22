require 'rails_distributed_tracing/distributed_tracing'

class RackHeaderModification
  def initialize(app)
    @app = app
  end

  def call(env)
    env[:headers].merge!({DistributedTracing::TRACE_ID => DistributedTracing.trace_id})
    @app.call(env)
  end
end
