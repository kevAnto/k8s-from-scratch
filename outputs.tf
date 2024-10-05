output "ec2_public_ip" {
  value = aws_instance.k8s-Master-server.public_ip
}