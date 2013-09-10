#!/usr/bin/env ruby
require './lib/whitecrow/aws_authorize_ip'

puts "account name"
a = gets.chomp
aws = WhiteCrow::AwsAuthorizeIP.new(:account => a)
puts aws.authorize_ip
puts "type 'rem' to revoke when you are done"
b = gets.chomp
if b.match("rem")
	puts aws.revoke_ip
end

# This is a little shell script example that prompts the user for the account name 
# that was stored in config/config.yml. The AwsAuthorizeIP class will then take care of
# setting up the AWS object and calling the methods correctly.
# When the user is done, they may revoke the SecurityGroup entry by typing rem.
# There is no error handling

# The yaml file looks like This

# account_name:
#     access_key_id: "key"
#     secret_access_key: "key"
#     security_group: "key"
#     aws_region: "key"

# The account_name is the same one the user would type at the "account name" prompt