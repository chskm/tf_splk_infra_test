resource "aws_instance" "splk_hf_az_a" {
  #ami           = data.aws_ami.ubuntu.id
  ami               = var.ami_id
  instance_type     = var.splk_hf_instance_type
  availability_zone = "us-east-1a"
  count             = var.hf_count
  key_name          = aws_key_pair.splk-key.key_name
  #subnet_id = var.subnet_1
  #subnet_id = element(local.subs, count.index)
  vpc_security_group_ids = [aws_security_group.splk-sg.id]
  subnet_id              = aws_subnet.subnet_1.id

  tags = {
    #Name = element(var.tags, count.index)
    Name = join("_", ["splk-hf", count.index + 1])
    #Name = ${element(split(",", lookup(var.tags,var.az_mapping,count.index)), 0)}
  }

  depends_on = [aws_main_route_table_association.splk-default-rt]
  provisioner "local-exec" {
    command = <<EOF
    aws --profile ${var.profile} ec2 wait instance-status-ok --region ${var.region} --instance-ids ${self.id}
    ansible-playbook --extra-vars 'passed_in_hosts=tag_Name_${self.tags.Name}' ansible_playbooks/splk_sample.yml
    EOF
  }
}

resource "aws_instance" "splk_hf_az_b" {
  #ami           = data.aws_ami.ubuntu.id
  ami               = var.ami_id
  instance_type     = var.splk_hf_instance_type
  availability_zone = "us-east-1b"
  count             = var.hf_count
  key_name          = aws_key_pair.splk-key.key_name
  #subnet_id         = var.subnet_2
  #subnet_id = element(local.subs, count.index)
  vpc_security_group_ids = [aws_security_group.splk-sg.id]
  subnet_id              = aws_subnet.subnet_2.id
  tags = {
    #Name = element(var.tags, count.index)
    Name = join("_", ["splk-hf", count.index + 1])
    #Name = ${element(split(",", lookup(var.tags,var.az_mapping,count.index)), 1)}
  }
  depends_on = [aws_main_route_table_association.splk-default-rt]
}

resource "aws_key_pair" "splk-key" {
  provider   = aws
  key_name   = "splk-key"
  public_key = file("~/.ssh/id_rsa.pub")
}