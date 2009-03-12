module Babylon
  
  ##
  # Runner is in charge of running the application.
  class Runner

    ##
    # When run is called, it loads the configuration, the routes and add them into the router
    # It then loads the models.
    # Finally it starts the EventMachine and connect the ComponentConnection
    # You can pass an additional block that will be called upon launching, when the eventmachine has been started.
    def self.run(&callback)       
      # Starting the EventMachine
      EventMachine.epoll
      EventMachine::run do
        params = [Babylon.config.merge({:on_stanza => CentralRouter.method(&:route)}), CentralRouter.method(&:connected)] 
        case Babylon.config["application_type"]
          when "client"
            Babylon::ClientConnection.connect(params)
          else # By default, we assume it's a component
          Babylon::ComponentConnection.connect(params)
        end
        
        # Requiring all models
        Dir.glob('app/models/*.rb').each { |f| require f }

        # Load the controllers
        Dir.glob('app/controllers/*_controller.rb')).each {|f| require f }

        Babylon.config = YAML::load(File.new('config/config.yaml'))[BABYLON_ENV] 

        #  Require routes defined with the new DSL router.
        require "config/routes"
        
        # And finally, let's allow the application to do all it wants to do after we started the EventMachine!
        callback.call if callback
      end
    end
    
  end
end
