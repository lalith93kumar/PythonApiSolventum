resource "aws_security_group" "apiSecurityRules" {
    name = "${var.clusterName}-connection_rules_rds"
    description = "connection rules for connecting RDS"
    vpc_id = var.vpc_id
    ingress {
        description = "open connection to 5000"
        from_port = 5000
        to_port = 5000
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "tcp"
    }

    egress {
        description = "ouboud rule"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Environment = var.clusterName
        name = "security_group_rds"
    }
}