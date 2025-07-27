output "instance_public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_eip.eip.public_ip
}

output "ec2_instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.my_ec2.id
}
