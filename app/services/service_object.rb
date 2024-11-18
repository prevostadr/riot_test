class ServiceObject
  def initialize(**params)
    # Setup all params as instance variables
    params.each do |attribute, value|
      instance_variable_set("@#{attribute}", value)
    end

    methods.select { |name| name.to_s.include?("assert_presence_of") }.each do |assert|
      public_send(assert)
    end
  end

  class << self
    def required_argument(*args)
      args.each do |key|
        define_method "assert_presence_of_#{key.to_s.underscore}" do
          if instance_variables.exclude?("@#{key}".to_sym)
            raise ArgumentError, "Missing required argument : #{key}"
          end
        end
      end
    end

    def call(**args)
      new(**args)&.call
    end
  end
end
