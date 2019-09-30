resource "aws_s3_bucket" "wp_content" {
  bucket = "gt-multisite-content"
  acl    = "public-read"
}
