output "jupyter_url" {
  value = "http://${aws_instance.serhiy.public_ip}:8888"
}

output "warning" {
  value = "It takes some time to configure server and download container image\nPlease be patient."
}

//output "password" {
//  value = "0493R34980"
//}

