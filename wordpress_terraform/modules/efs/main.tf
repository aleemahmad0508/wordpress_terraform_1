resource "aws_efs_file_system" "wordpress_efs" {
    creation_token = "wordpress-efs"
    performance_mode = "generalPurpose"
    encrypted = true
    tags = {
        Name = "wordpress-efs"
    }
  
}

resource "aws_efs_mount_target" "wordpress_efs_mount_target_1" {
    file_system_id = aws_efs_file_system.wordpress_efs.id
    subnet_id = var.private_subnet_1_id
    security_groups = [var.security_group_id]
}

resource "aws_efs_mount_target" "wordpress_efs_mount_target_2" {
    file_system_id = aws_efs_file_system.wordpress_efs.id
    subnet_id = var.private_subnet_2_id
    security_groups = [var.security_group_id]
}