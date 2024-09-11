resource "aws_db_instance" "example" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "12.3"
  instance_class       = "db.t2.micro"
  db_name              = "mydb"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.postgres12"
  skip_final_snapshot  = true
  vpc_security_group_ids = [var.security_group_ids]
  db_subnet_group_name = aws_db_subnet_group.default.name
  publicly_accessible = true
  tags = {
    Name = "example-db"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "mydb-subnet-group"
  subnet_ids = var.public_subnet_name

  tags = {
    Name = "mydb-subnet-group"
  }
}

resource "null_resource" "init_db" {
  provisioner "local-exec" {
    command = <<EOT
      echo "USE mydb; CREATE TABLE IF NOT EXISTS TemperatureReading (id INT AUTO_INCREMENT, sensor_id VARCHAR(255) NOT NULL, temperature FLOAT NOT NULL, time TIMESTAMP NOT NULL, PRIMARY KEY (id));" | mysql -h ${split(":",aws_db_instance.example.endpoint)[0]} -P 3306 -u foo -p'foobarbaz'
    EOT
  }

  depends_on = [aws_db_instance.example,aws_db_subnet_group.default]
}