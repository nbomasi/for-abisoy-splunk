output "zone_id" {
  description = "The ID of the hosted zone"
  value       = aws_route53_zone.internal_zone.zone_id
}

output "zone_name" {
  description = "The ID of the hosted zone"
  value       = aws_route53_zone.internal_zone.name
}

output "nameservers" {
  description = "The nameservers of the hosted zone"
  value       = aws_route53_zone.internal_zone.name_servers
}

output "alias_records" {
  description = "The A records"
  value       = aws_route53_record.alias_internal_record
}

output "squid-proxy_zone_name" {
  description = "The ID of the Squid-proxy hosted zone"
  value       = aws_route53_zone.squid-proxy_zone.name
}
