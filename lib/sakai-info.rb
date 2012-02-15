# sakai-info.rb
#   Base library file
#
# Created 2012-02-15 daveadams@gmail.com
# Last updated 2012-02-15 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

require 'yaml'

module SakaiInfo
  class ScholarException < Exception; end
  class InvalidDateException < ScholarException; end
  class InvalidConfigException < ScholarException; end

  class Config
    # validate that configuration is complete and well-formed
    def self.validate_config(config)
      return false if config.nil? or not config.is_a? Hash

      # check for required keys
      %w(dbtype dbuser dbpass).each do |key|
        if config[key].nil?
          return false
        end
      end

      # check for valid database type
      if not ( config["dbtype"] == "mysql" or config["dbtype"] == "oracle" )
        return false
      end

      # check for mysql specific keys
      if config["dbtype"] == "mysql"
        %w(dbname dbhost dbport).each do |key|
          if config[key].nil?
            return false
          end
        end
      end

      # check for oracle specific keys
      if config["dbtype"] == "oracle"
        if config["dbsid"].nil?
          return false
        end
      end

      # if we made it here the config is complete and well-formed
      return true
    end

    def initialize(config)
      begin
        if config.is_a? Hash
          @config = config
        elsif config.is_a? String and File.exist?(config)
          # try to parse as a filename first
          if File.exist?(config)
            YAML::load_file(config)
          end
        else
          # otherwise try to parse it generically
          @config = YAML::load(config)
        end
      rescue Exception => e
        raise InvalidConfigException.new("Unable to parse configuration: #{e}")
      end

      if not self.validate_config(@config)
        raise InvalidConfigException.new("Config provided is either incomplete or poorly formed.")
      end
    end
  end

  class DB
  end

  class SakaiObject
  end

  class SakaiXMLEntity < SakaiObject
  end
end

# extensions to other objects
class String
  def is_uuid?
    self =~ /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i
  end
end

# TODO: include other libs here

