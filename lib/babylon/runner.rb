module Babylon
  
  ##
  # Runner is in charge of running the application.
  class Runner
    
    ## 
    # Prepares the Application to run.
    def self.prepare(env)
      # Load the configuration
      config_file = File.open('config/config.yaml')
      Babylon.config = YAML.load(config_file)[Babylon.environment]
      
      # Add an outputter to the logger
      log_file = Log4r::RollingFileOutputter.new("#{Babylon.environment}", :filename => "log/#{Babylon.environment}.log", :trunc => false)
      case Babylon.environment
      when "production"
        log_file.formatter = Log4r::PatternFormatter.new(:pattern => "%d (#{Process.pid}) [%l] :: %m", :date_pattern => "%d/%m %H:%M")      
      when "development"
        log_file.formatter = Log4r::PatternFormatter.new(:pattern => "%d (#{Process.pid}) [%l] :: %m", :date_pattern => "%d/%m %H:%M")      
      else
        log_file.formatter = Log4r::PatternFormatter.new(:pattern => "%d (#{Process.pid}) [%l] :: %m", :date_pattern => "%d/%m %H:%M")      
      end
      Babylon.logger.add(log_file)
      
      # Requiring all models, stanza, controllers
      ['app/models/*.rb', 'app/stanzas/*.rb', 'app/controllers/*_controller.rb'].each do |dir|
        Runner.require_directory(dir)
      end
      
      # Create the router
      Babylon.router = Babylon::StanzaRouter.new
      
      # Evaluate routes defined with the new DSL router.
      require 'config/routes.rb'
            
      # Caching views
      Babylon.cache_views
      
    end
    
    ##
    # Convenience method to require files in a given directory
    def self.require_directory(path)
      Dir.glob(path).each { |f| require f }
    end
    
    ##
    # When run is called, it loads the configuration, the routes and add them into the router
    # It then loads the models.
    # Finally it starts the EventMachine and connect the ComponentConnection
    # You can pass an additional block that will be called upon launching, when the eventmachine has been started.
    def self.run(env)
      
      Babylon.environment = env
      
      # Starting the EventMachine
      EventMachine.epoll
      EventMachine.run do
        
        Runner.prepare(env)
        
        case Babylon.config["application_type"] 
        when "client"
          Babylon::ClientConnection.connect(Babylon.config, self) 
        else # By default, we assume it's a component
          Babylon::ComponentConnection.connect(Babylon.config, self) 
        end
        
        # And finally, let's allow the application to do all it wants to do after we started the EventMachine!
        yield(self) if block_given?
      end
    end
    
    ##
    # Returns the list of connection observers
    def self.connection_observers()
      @@observers ||= Array.new
    end
    
    ##
    # Adding a connection observer. These observer will receive on_connected and on_disconnected events.
    def self.add_connection_observer(observer)
      @@observers ||= Array.new 
      if observer.ancestors.include? Babylon::Base::Controller
        Babylon.logger.debug {
          "Added #{observer} to the list of Connection Observers"
        }
        @@observers.push(observer) unless @@observers.include? observer
      else
        Babylon.logger.error {
          "Observer can only be Babylon::Base::Controller"
        }
        false
      end
    end
    
    ## 
    # Will be called by the connection class once it is connected to the server.
    # It "plugs" the router and then calls on_connected on the various observers.
    def self.on_connected(connection)
      Babylon.router.connected(connection)
      connection_observers.each do |observer|
        Babylon.router.execute_route(observer, "on_connected")
      end
    end
    
    ##
    # Will be called by the connection class upon disconnection.
    # It stops the event loop and then calls on_disconnected on the various observers.
    def self.on_disconnected()
      connection_observers.each do |conn_obs|
        observer = conn_obs.new
        observer.on_disconnected if observer.respond_to?("on_disconnected")
      end
      EventMachine.stop_event_loop
    end
    
    ##
    # Will be called by the connection class when it receives and parses a stanza.
    def self.on_stanza(stanza)
      begin
        Babylon.router.route(stanza)
      rescue Babylon::NotConnected
        Babylon.logger.fatal {
          "#{$!.class} => #{$!.inspect}\n#{$!.backtrace.join("\n")}"
        }
        EventMachine::stop_event_loop
      rescue
        Babylon.logger.error {
          "#{$!.class} => #{$!.inspect}\n#{$!.backtrace.join("\n")}"
        }
      end
    end
    
  end
end
