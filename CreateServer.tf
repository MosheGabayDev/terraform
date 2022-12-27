provider "aws" {
    shared_credentials_files = "${var.shared_credentials_files}"
    region = "${var.aws_region}"
}

resource "aws_instance" "tf-test" {

    count = 4

    ami = "ami-01c5474ddacc5ed1a"
    instance_type = "t2.small"
    key_name = "HTTP-server"
    
    tags = {
        Name = "tf-test"
        Create_by = "Terraform"
        JIRAtiketID = ""
    }
}

resource "aws_security_group" "terraform_sg1" {
    name = "terraform_sg1"
    vpc_id = "vpc-eebe0997"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    
    tags = {
        type = "terraform-test-security-group"
    }
}

resource "aws_network_interface_sg_attachment" "sg_attachment1" {
  security_group_id    = aws_security_group.terraform_sg1.id
  network_interface_id = aws_instance.tf-test[0].primary_network_interface_id
}

resource "aws_network_interface_sg_attachment" "sg_attachment2" {
  security_group_id    = aws_security_group.terraform_sg1.id
  network_interface_id = aws_instance.tf-test[1].primary_network_interface_id
}

resource "aws_network_interface_sg_attachment" "sg_attachment3" {
  security_group_id    = aws_security_group.terraform_sg1.id
  network_interface_id = aws_instance.tf-test[2].primary_network_interface_id
}

resource "aws_network_interface_sg_attachment" "sg_attachment4" {
  security_group_id    = aws_security_group.terraform_sg1.id
  network_interface_id = aws_instance.tf-test[3].primary_network_interface_id
}