resource "aws_s3_bucket" "example" {
  bucket = "platform-team-staticwebsite"

  tags = {
    Name        = "TestBucket"
    Environment = "POC"
  }
}

resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.example.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.example.id
  key    = "index.html"
  source = "./index.html"
}

resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.example.id
  key    = "error.html"
  source = "./error.html"
}
