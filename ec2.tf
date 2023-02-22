# Defining the EC2 resource creation
resource "aws_instance" "ec2_instance" {
  ami                          = "${var.ami_id}" # Use the latest version of the Golden image and please do not use Marketplace images
  availability_zone            = "${var.avb_zone}"
  instance_type                = "${var.instance_type}"
  subnet_id                    = "${var.subnet_id}"
  key_name                     = "${var.key_name}"
  iam_instance_profile         = "iar-ssm-role"
  vpc_security_group_ids = "${var.sg_ids}"
  #user_data = "${file("../ec2_instance_web/user_data_file.sh")}"	###User data to resize the root volume
  disable_api_termination      = "true"
  tags      = "${merge(tomap({"Name"=var.ec2_name}),var.tags)}"
  volume_tags = "${merge(tomap({"Name"=var.ec2_name}),var.tags)}"


	root_block_device {
          volume_size           = "${var.root_volume_size}"
          volume_type           = "gp2"
		  encrypted				= "true"
		  kms_key_id 			= "${var.kms_key_arn}"
		  }
		  
	ebs_block_device {
		  device_name	=	"/dev/sdb"
          volume_size           = "${var.ebs_volume_size}"
          volume_type           = "gp2"
		  encrypted				= "true"
		  kms_key_id 			= "${var.kms_key_arn}"
		  }
}


output "ec2_id" {
  value = "${aws_instance.ec2_instance.id}"
}

output "ec2_instance_type" {
   value = "${aws_instance.ec2_instance.instance_type}"
   }

output "ec2_ami_id" {
   value = "${aws_instance.ec2_instance.ami}"
   }
   