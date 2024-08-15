resource "aws_security_group" "db_sg" {
  name        = "Database Postgres"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.this[0].id

  ingress {
    description = "TLS from VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.this[0].cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-${var.env}-rds-psql-cluster-1"
  }
}