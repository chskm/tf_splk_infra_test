# Splunk Infra ouput values
output "splk-hf-public-ip_az_a" {
  value = {
    for instance in aws_instance.splk_hf_az_a :
    instance.id => instance.public_ip
  }
}

output "splk-hf-public-ip_az_b" {
  value = {
    for instance in aws_instance.splk_hf_az_b :
    instance.id => instance.public_ip
  }
}