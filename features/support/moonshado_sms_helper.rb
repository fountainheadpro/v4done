module Moonshado
  class Sms
    @@delivered_sms = {}

    alias_method :stub_deliver_sms, :deliver_sms

    def self.delivered_sms
      @@delivered_sms
    end

    def save_delivered_sms
      response = stub_deliver_sms
      @@delivered_sms[@number] ||= []
      @@delivered_sms[@number] << { message: @message, response: response }
    end

    alias_method :deliver_sms, :save_delivered_sms
  end
end