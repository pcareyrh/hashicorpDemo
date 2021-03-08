output "public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = module.ec2_instances.public_ip
}

output "instance_id" {
  description = "List of instance id"
  value       = module.ec2_instances.id
}