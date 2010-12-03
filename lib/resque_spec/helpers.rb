module ResqueSpec
  module Helpers

    def with_resque
      enable_perform
      yield
      disable_perform
    end

    private

    def enable_perform
      ::Resque.module_eval do
        def self.enqueue(klass, *args)
          klass.perform(*args)
        end
      end
    end

    def disable_perform
      ::Resque.module_eval do
        def self.enqueue(klass, *args)
          ResqueSpec::Resque.enqueue(klass, *args)
        end
      end
    end
  end
end
