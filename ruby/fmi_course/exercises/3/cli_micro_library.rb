class CommandParser
  class Argument
    attr_accessor:handler
    attr_accessor:command_name

    def initialize(name, handler)
      @name = name
      @handler = handler
    end

    def execute(*handler_arguments)
      @handler.call handler_arguments
    end
  end

  class Option
    def initialize(short_name, long_name, description, handler)
      @short_name = short_name
      @long_name = long_name
      @description = description
      @handler = handler
    end

    def execute(*handler_arguments)
      @handler.call handler_arguments[0], true  # TODO: refactor this ?
    end
  end

  class OptionWithParameter < Option
    def initialize(short_name, long_name, description, parameter, handler)
      super(short_name, long_name, description, handler)
      @parameter = parameter
    end

    def execute(*handler_arguments)
      runner = handler_arguments[0]
      full_argument = handler_arguments[1]

      if full_argument.start_with? '--'
        argument = full_argument.split('=')[1]
      else
        argument = full_argument.slice(2..-1)
      end


      @handler.call runner, argument  # TODO: refactor this ?
    end
  end

	def initialize(command_name)
		@command_name = command_name
    @arguments_and_options = []
	end

  def argument(argument_name, &block)
    argument = Argument.new(argument_name, block)
    @arguments_and_options.push(argument)
  end

  def option(short_name, long_name, description, &block)
    option = Option.new(short_name, long_name, description, block)
    @arguments_and_options.push(option)
  end

  def option_with_parameter(short_name, long_name, description, parameter, &block)
    option = OptionWithParameter.new(short_name, long_name, description, parameter, block)
    @arguments_and_options.push(option)
  end

  def parse(command_runner, argv)
    argv.each_with_index do |element, index|
      @arguments_and_options[index].execute(command_runner, element)
    end
  end
end
