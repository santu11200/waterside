resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${var.keypair_name}"
  public_key = tls_private_key.example.public_key_openssh

}

resource "aws_secretsmanager_secret" "secret_key" {
  name = "${var.keypair_name}"
  kms_key_id = "${var.kms_id}"
  description = "ec2_key"
}

resource "aws_secretsmanager_secret_version" "secret_key_value" {
  secret_id     = aws_secretsmanager_secret.secret_key.id
  secret_string = tls_private_key.example.private_key_pem
}  