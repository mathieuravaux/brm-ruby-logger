require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

RABBITMQ_HOST = 'mimesis12.typhon.net'
RABBITMQ_PORT = 5672
RABBITMQ_USERNAME = 'guest'
RABBITMQ_PASSWORD = 'guest'
RABBITMQ_VHOST = '/'

# RABBITMQ_VHOST = 'bmbubbler_test'
# RABBITMQ_USERNAME = 'blackmamba'
# RABBITMQ_PASSWORD = 'blackmamba'



describe "BrmLogger" do
  before(:each) do
    user_id = "123"
    application = "brm-ruby-logger-tests"
    @logger = BrmLogger::Logger.new(user_id, application,
      # :logging => true,
      :host => RABBITMQ_HOST,
      :port => RABBITMQ_PORT,
      :user => RABBITMQ_USERNAME,
      :pass => RABBITMQ_PASSWORD,
      :vhost => RABBITMQ_VHOST
    )
  end
  
  after(:each) do
    @logger.disconnect
  end
  
  it  "should connect to the QA RabbitMQ" do
  end
  
  it "should send custom events" do
    @logger.message("think", { "id" => "123", "type" => "facet" }, "Salut");
  end
  
  it "should send generic Action events" do
    # action (générique), dont envoi de post
    @logger.action "Salut"
  end
  
  it "should send user sign-ins" do
    @logger.facet_id = "JeanClaude"
    @logger.sign_in "test_service"
  end

  it "should send user account creation events" do
    @logger.describe "create", {"id" => "123", "type" => "User", "name" => "Bob" }
  end
  
end
