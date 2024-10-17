
resource "aws_security_group" "control-plane-sg" {
  vpc_id = aws_vpc.k8s-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH access"
  }

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow Kubernetes API server access"
  }

  ingress {
    from_port   = 2379
    to_port     = 2380
    protocol    = "tcp"
    cidr_blocks = [var.subnet_1_cidr_block]
    description = "Allow etcd server client API access"
  }

  ingress {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow Kubelet API access"
  }

  ingress {
    from_port   = 10259
    to_port     = 10259
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow kube-scheduler access"
  }

  ingress {
    from_port   = 10257
    to_port     = 10257
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow kube-controller-manager access"
  }

  
  ingress {
    from_port   = 8472
    to_port     = 8472
    protocol    = "udp"
    #security_groups = [aws_security_group.control-plane-sg.id]
    cidr_blocks = [var.subnet_1_cidr_block]
    description = "Allow cilium access from within the same security group"
  }

  ingress {
    from_port   = 8472
    to_port     = 8472
    protocol    = "udp"
    #security_groups = [aws_default_security_group.workers-sg.id]
    cidr_blocks = [var.subnet_1_cidr_block]
    description = "Allow cilium access from within the workerNode security group"
  }

  ingress {
    from_port   = 4240
    to_port     = 4240
    protocol    = "udp"
    #security_groups = [aws_security_group.control-plane-sg.id]
    cidr_blocks = [var.subnet_1_cidr_block]
    description = "Allow cilium helthcheck within the same security group"
  }

  ingress {
    from_port   = 4240
    to_port     = 4240
    protocol    = "udp"
    #security_groups = [aws_default_security_group.workers-sg.id]
    cidr_blocks = [var.subnet_1_cidr_block]
    description = "Allow cilium helthcheck within the workerNode security group"
  }

  ingress {
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    #security_groups = [aws_security_group.control-plane-sg.id]
    cidr_blocks = [var.subnet_1_cidr_block]
    description     = "Allow all ICMP traffic within the control-plane security group"
  }

  ingress {
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    #security_groups = [aws_default_security_group.workers-sg.id]
    cidr_blocks = [var.subnet_1_cidr_block]
    description     = "Allow all ICMP traffic within the workerNode security group"
  }

  ingress {
    from_port       = 30000
    to_port         = 32767
    protocol        = "tcp"
    #security_groups = [aws_security_group.control-plane-sg.id]
    cidr_blocks = [var.subnet_1_cidr_block]
    description     = "Allow custom TCP traffic within range 30000-32767(nodePort range) from the control-plane security group "
  }

  ingress {
    from_port       = 30000
    to_port         = 32767
    protocol        = "tcp"
    #security_groups = [aws_default_security_group.workers-sg.id]
    cidr_blocks = [var.subnet_1_cidr_block]
    description     = "Allow custom TCP traffic within range 30000-32767(nodePort range) from the workerNode security group"
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env_prefix}-Control-Plane-SG"
  }
}


resource "aws_default_security_group" "workers-sg" {
  vpc_id = aws_vpc.k8s-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # "-1" means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 8472
    to_port     = 8472
    protocol    = "udp"
    #security_groups = [aws_security_group.control-plane-sg.id]
    cidr_blocks = [var.subnet_2_cidr_block]
    description = "Allow cilium access from within the same security group"
  }

  ingress {
    from_port   = 8472
    to_port     = 8472
    protocol    = "udp"
    #security_groups = [aws_default_security_group.workers-sg.id]
    cidr_blocks = [var.subnet_2_cidr_block]
    description = "Allow cilium access from within the workerNode security group"
  }

  ingress {
    from_port   = 4240
    to_port     = 4240
    protocol    = "udp"
    #security_groups = [aws_security_group.control-plane-sg.id]
    cidr_blocks = [var.subnet_2_cidr_block]
    description = "Allow cilium helthcheck within the same security group"
  }

  ingress {
    from_port   = 4240
    to_port     = 4240
    protocol    = "udp"
    #security_groups = [aws_default_security_group.workers-sg.id]
    cidr_blocks = [var.subnet_2_cidr_block]
    description = "Allow cilium helthcheck within the workerNode security group"
  }

  ingress {
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    #security_groups = [aws_security_group.control-plane-sg.id]
    cidr_blocks = [var.subnet_2_cidr_block]
    description     = "Allow all ICMP traffic within the control-plane security group"
  }

  ingress {
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    #security_groups = [aws_default_security_group.workers-sg.id]
    cidr_blocks = [var.subnet_2_cidr_block]
    description     = "Allow all ICMP traffic within the workerNode security group"
  }

  ingress {
    from_port       = 30000
    to_port         = 32767
    protocol        = "tcp"
    #security_groups = [aws_security_group.control-plane-sg.id]
    cidr_blocks = [var.subnet_2_cidr_block]
    description     = "Allow custom TCP traffic within range 30000-32767(nodePort range) from the control-plane security group "
  }

  ingress {
    from_port       = 30000
    to_port         = 32767
    protocol        = "tcp"
    #security_groups = [aws_default_security_group.workers-sg.id]
    cidr_blocks = [var.subnet_2_cidr_block]
    description     = "Allow custom TCP traffic within range 30000-32767(nodePort range) from the workerNode security group"
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  tags = {
    Name = "${var.env_prefix}-workers-SG"
  }
}