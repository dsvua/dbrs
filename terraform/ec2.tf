resource "aws_instance" "serhiy" {
  depends_on = ["null_resource.iam_delay"]
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.allow_8888.id}"]
  subnet_id = "${aws_subnet.serhiy.id}"
  key_name = "${aws_key_pair.serhiy.key_name}"

  root_block_device {
    volume_size = "20"
  }

  user_data = <<EOF
#!/usr/bin/env bash
apt-add-repository ppa:ansible/ansible -y
apt-get update
apt-get install git ansible -y
git clone https://github.com/dsvua/dbrs.git /opt/serhiy/dbrs
cd /opt/serhiy/dbrs/ansible
ansible-galaxy install geerlingguy.docker geerlingguy.pip -p roles/
ANSIBLE_CONFIG=ansible.cfg ansible-playbook site.yaml
EOF
  tags {
    Name = "serhiy"
  }
}

//resource "aws_key_pair" "serhiy" {
//  depends_on = ["null_resource.iam_delay"]
//  key_name   = "serhiy-pub-key"
//  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCwBI4aMx9Pr3NobfslzXhCBxa+9FBdfHSmyorSWTeL6epSOQJYoZzMuv8hZaOqmgec7hJBuaiQzdtIXR13wBHmDB+H5K7xmNh9Yk79KHABYITyzpFvrgOYHtpElpWLumQ9KSTVg/TrFH3FgTtBVATCvyATPKLtIPMR1XCZhacMfgWAC+/b8dJ+Ztcbufb3QYMnsbtHFUwtwIO/g1HUy2ulR+2yRSfJQkfcBK4ArCjT5HrfZzShdSI35BcgpFURYU/UG5n5xi+AKBA30YYs5/zRz39O3NBWneeWzOWRI49Dc5ax3jDrF71xaIuATVrLBZfQWSErKuFoq2WcYsA8CxLqLf+11Pln8nb78aF1pQf11pocddAKJnGueDIQ9if8YNt98phTLtRlHOK4b5zoA8xEtXek8V9veCarrjX+tIYPU/3zDX2LbP1aa+JcEQaV/tU3VlIQD8cPyi+dcP1I9UjuBGjNUYSEA5IcWvx4KTGTh2kL1EzXgWDvELgrdTzg0UY9WWwSOjvCj0MT31ze2aLpBa2drD41P/lYEw7kKII2rNIYcJTvEOcMxQMMgUJPp7CSB35V/MpR4n0LWqm1MtgL+6gh5HCz49b57wkrn86ZFaDBQatAl7CEhQZccZB85v5qoWwHse9rdCgZDBLKe3+a1wl6cfiLN+bRPKUv2izyLQ== serhiy@Serhiys-Mini.home"
//}
