provider "aws" {
  region = "us-east-1" 
}

resource "aws_lightsail_instance" "test" {
  name              = "team"
  availability_zone = "us-east-1a" 
  blueprint_id      = "centos_7"
  bundle_id         = "nano_2_0"

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install unzip wget httpd -y
              sudo wget https://github.com/utrains/static-resume/archive/refs/heads/main.zip
              sudo unzip main.zip
              sudo rm -rf /var/www/html/*
              sudo cp -r static-resume-main/* /var/www/html/
              sudo systemctl start httpd
              sudo systemctl enable httpd
              EOF
}

output "public_ip" {
  value = aws_lightsail_instance.team.public_ip_address
}
