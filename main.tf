provider "aws" {
  profile = "default"
  region  = "eu-central-1"
}

# New resource for the S3 bucket our application will use.
resource "aws_s3_bucket" "mk-tf-bucket-001" {
  # NOTE: S3 bucket names must be unique across _all_ AWS accounts, so
  # this name must be changed before applying this example to avoid naming
  # conflicts.
  bucket = "mk-tf-bucket-f-001"
  acl    = "private"
}

resource "aws_instance" "example" {
  #ami           = "ami-0df0e7600ad0913a9"
  ami           = "ami-0badcc5b522737046"
  instance_type = "t2.micro"
  # vpc_security_group_ids = ["sg-0077..."]
  # subnet_id = "subnet-923a..."
  depends_on = [aws_s3_bucket.mk-tf-bucket-001]
}

resource "aws_eip" "ip" {
  vpc      = true
  instance = aws_instance.example.id
}

resource "aws_instance" "another" {
  ami           = "ami-0ca9e27238973cf36"
  instance_type = "t2.micro"
}
