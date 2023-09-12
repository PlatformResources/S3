provider "aws" {
  region     = "us-east-1"
 }

resource "aws_s3_bucket" "example" {
  bucket = "platform-resources-perficient-folks"
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.example.id
  key    = "index.html"
  source = "./index.html"
  acl = "public-read"
  content_type = "text/html"
depends_on = [
    aws_s3_bucket_acl.example,
    ]
}

resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.example.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.example.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.example.id
  acl    = "private"
}

output "website_domain" {
  value = aws_s3_bucket_website_configuration.example.website_domain
}

output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.example.website_endpoint
}


/*
resource "aws_s3_bucket_policy" "example" {
  bucket = aws_s3_bucket.static_website.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = ["s3:GetObject"],
        Effect = "Allow",
        Principal = "*",
        Resource = "${aws_s3_bucket.static_website.arn}",
      },
    ],
  })
}

*/
