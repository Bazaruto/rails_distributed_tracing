project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + '/rails_distributed_tracing/*.rb', &method(:require))
