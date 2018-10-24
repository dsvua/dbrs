output "jupyter_url" {
  value = "http://${aws_instance.serhiy.public_ip}:8888"
}

output "password" {
  value = "0493R34980"
}

