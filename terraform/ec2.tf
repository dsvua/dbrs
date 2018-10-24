resource "aws_instance" "serhiy" {
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.allow_8888.id}"]
  user_data = <<-EOF
apt-get install git
amazon-linux-extras -y install ansible2
git clone https://github.com/dsvua/dbrs.git /opt/serhiy/dbrs
cd /opt/serhiy/dbrs/ansible
ansible-galaxy install geerlingguy.docker geerlingguy.pip -p ansible/roles/
ANSIBLE_CONFIG=ansible.cfg ansible-playbook ansible/site.yaml
EOF
  tags {
    Name = "serhiy"
  }
}