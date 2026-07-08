output "wordpress_instance_1_id" {
  value = aws_instance.wordpress_1.id

}
output "wordpress_instance_2_id" {
  value = aws_instance.wordpress_2.id

}
output "wordpress_instance_1_public_ip" {
  value = aws_instance.wordpress_1.public_ip
}

output "wordpress_instance_2_public_ip" {
  value = aws_instance.wordpress_2.public_ip
}

