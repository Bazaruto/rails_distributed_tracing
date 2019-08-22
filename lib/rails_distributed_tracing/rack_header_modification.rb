require 'rails_distributed_tracing/distributed_tracing'

class RackHeaderModification
  def initialize(app)
    @app = app
  end

  def call(env)
    @status, @headers, @response = @app.call(env)
    env.each do |k, v|
      Rails.logger.info("----------#{k} = #{v}-------------------\n\n\n\n\n\n\n\n\n\n")
    end
    @headers.merge!({DistributedTracing::TRACE_ID => DistributedTracing.trace_id})
    [@status, @headers, @response]
  end
end
