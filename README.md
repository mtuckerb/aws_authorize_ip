WhiteCrow::AwsAuthorizeIP
================

This is a little helper that sets an AWS SecurityGroup rule for your current IP
It basically wraps a small set of AWS SDK methods and makes it easy to create a new rule in an existing SecurityGroup. To get started

     git clone git@github.com:WhiteCrowProductions/aws_authorize_ip.git
     cd aws_authorize_ip
     vi config/config.yml

make a config like 

     arbitrary_name:
        access_key_id: "key"
        secret_access_key: "key"
        security_group: "key"
        aws_region: "key"

and then call the shell script like

     ./allow_ssh.rb

of course you can do fun stuff like 

     irb -r "./lib/WhiteCrow/aws_authorize_ip.rb"
     aws = WhiteCrow::AwsAuthorizeIP.new(account: "your account", security_group: "your group", current_ip: "something totally bogus")

that's up to you.
