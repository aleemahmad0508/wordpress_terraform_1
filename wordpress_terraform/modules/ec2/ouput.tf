output "aws_launch_tempelate_id" {
  value = aws_launch_template.wordpress_lt.id
  
}

output "aws_launch_tempelate_version" {
  value = aws_launch_template.wordpress_lt.latest_version
  
}


output "aws_autoscalling_name" {
  value = aws_autoscaling_group.wordpress_asg.name
  
}

output "aws_autoscalling_arn" {
   value= aws_autoscaling_group.wordpress_asg.arn  
}