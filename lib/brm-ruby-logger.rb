$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require "rubygems"
require "bunny"
require "active_support"
require "pp"

require "logger/event.rb"

module BrmLogger
  VERSION = File.read(File.join(File.dirname(__FILE__), '..', 'VERSION')).chomp

  class Logger
    attr_accessor :connection, :user_id, :facet_id, :application
  
    def sequence_number
      @sequence_number ||= 0
      @sequence_number += 1
    end

    def initialize(user_id, application,  *args)
     @user_id = user_id
     @application = application
     
     bunny_options = args.extract_options!
     @connection = Bunny.new bunny_options
     @connection.start
    end

    def disconnect()
      @connection.stop
    end

    def event(eventName, data=nil, context=nil, event_ref="")
      event = HashWithIndifferentAccess.new
      event["data"] = data || {}
      event["context"] = context || {}
      
      
      event["data"]["agent"] = {:id => facet_id, :type => "facet"} if facet_id

      if user_id
        event["data"]["agent"] ||= {:id => user_id, :type => "user"}
        event["context"]["userID"] = user_id
      end
      
      event["metaData"] = {
        "timestamp" => Time.now.to_i * 1000,
        "eventName"  => $eventName,
        "application" => application,
        "loggerVersion" => VERSION,
        "loggerType" => "ruby",
        "sequenceNumber" => sequence_number
      }

      event["metaData"]["eventRef"] = event_ref

      send event
    end
    
    
    
    private
    def send event
      
    end
  end

end