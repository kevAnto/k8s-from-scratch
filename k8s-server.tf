data "aws_ami" "latest-ubuntu-image" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "k8s-Master-server" {
  ami                         = data.aws_ami.latest-ubuntu-image.id
  instance_type               = var.instance_type
  key_name                    = "devops"
  subnet_id                   = aws_subnet.k8s-subnet-1.id
  vpc_security_group_ids      = [aws_default_security_group.control-plane-sg.id]
  availability_zone           = var.avail_zone
  associate_public_ip_address = true
  user_data                   = file("k8s-server-script.sh")
  tags = {
    Name = "${var.env_prefix}-Master"
  }
}
# k8s Worker Node Instances (Fixed at 2 instances)
resource "aws_instance" "k8s-worker" {
  count                       = 1  # Always start with 2 instances
  ami                         = data.aws_ami.latest-ubuntu-image.id
  instance_type               = var.instance_type
  key_name                    = "devops"
  subnet_id                   = aws_subnet.k8s-subnet-2.id
  vpc_security_group_ids      = [control-plane-sg.control-plane-sg.id]
  availability_zone           = var.avail_zone
  associate_public_ip_address = true
  user_data                   = file("k8s-worker-script.sh")  
  tags = {
    Name = "${var.env_prefix}-worker-${count.index + 1}"  # Unique name for each worker (e.g., worker-1, worker-2)
  }
}