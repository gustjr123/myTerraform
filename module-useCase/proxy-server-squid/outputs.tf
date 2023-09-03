output "IP" {
  description = "access IP"
  value       = module.squid.IP
}

output "account" {
  description = "access account user"
  value       = module.squid.account
}

output "password" {
  description = "access account password"
  value       = module.squid.password
}
