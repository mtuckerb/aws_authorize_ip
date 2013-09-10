require 'JSON';
require 'open-uri';
require 'aws-sdk'
module WhiteCrow
	class AwsAuthorizeIP

		attr_accessor :current_ip, :access_key_id, :secret_access_key, 
			:security_group, :sg, :new_rule, :account, :aws_region

		def initialize(attributes = {})
			attributes.each do |name, value|
			  send("#{name}=", value)
			end
			YAML.load_file((File.expand_path File.dirname(__FILE__)) + "/../../config/config.yml")[account].each do |name, value|
				send("#{name}=", value)
			end

			AWS.config(access_key_id: @access_key_id, secret_access_key: @secret_access_key, region: @aws_region)

		end

		def authorize_ip
			begin
				set_current_ip
				sg_connect
				self.new_rule = self.sg.authorize_ingress("tcp", 22, "#{current_ip}/32")
				return self.new_rule
			rescue AWS::EC2::Errors::InvalidPermission::Duplicate
				return "That Rule already exists"
			end
		end

		def revoke_ip
			set_current_ip unless self.current_ip
			sg_connect unless self.sg
			self.new_rule = self.sg.revoke_ingress("tcp", 22, "#{current_ip}/32")
			return self.new_rule
		end

		def sg_connect
			self.sg = AWS::EC2::SecurityGroup.new(@security_group)
		end
		
		def set_current_ip
			self.current_ip =  open( 'http://jsonip.com/ ' ){ |s| JSON::parse( s.string())['ip'] };
		end

	end
end