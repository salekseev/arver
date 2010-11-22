module Arver
  class CommandWrapper

    @@test_failure = false
    def self.test_failure
      @@test_failure = true
    end
    
    @@test_spoof_output= nil
    def self.test_spoof_output( output )
      @@test_spoof_output= output
    end 

    attr_accessor :command, :arguments_array, :return_value, :output
  
    def initialize( cmd, args = [] )
      self.command= cmd
      self.arguments_array= args
    end
  
    def escaped_command
      Escape.shell_command([ command ] + arguments_array )
    end
  
    def escaped_total_command( input )
      if( input.empty? )
        self.escaped_command
      else
        Escape.shell_command( ["echo", input] ) + " | " + self.escaped_command
      end
    end

    def execute( input = "")
      self.run( self.escaped_total_command( input ) )
    end
    
    
    def success?
      return_value == 0
    end
    
    def run( command )
      Arver::Log.trace( "** Execute: "+command )
      if( Arver::RuntimeConfig.instance.test_mode || Arver::RuntimeConfig.instance.dry_run )
        self.output= ""
        self.return_value= 0
      else
        self.output= `#{command}`
        self.return_value= $?
      end
      if( @@test_failure )
        self.return_value= 1
      end
      if( ! @@test_spoof_output.nil? )
        self.output= @@test_spoof_output
      end
      self.success?
    end
  end
end
