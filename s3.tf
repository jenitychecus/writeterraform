
resource "aws_s3_bucket" "terraformbucket" {
    bucket = "myawsbucketterraform-gracejen-20250723"
 }
resource "aws_s3_bucket_versioning" "sv_example" {
    bucket = aws_s3_bucket.terraformbucket.id
    versioning_configuration {
        status = "Enabled"
  }
}
