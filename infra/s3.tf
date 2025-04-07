resource "aws_s3_bucket" "dd_take_home_site" {
  bucket = "datadog-take-home.floriantz.com"
  
  tags = {
    environment = "production"
    application = "datadog-take-home.floriantz.com"
  }
}

resource "aws_s3_bucket_ownership_controls" "dd_take_home_site_public_ownership_controls" {
  bucket = aws_s3_bucket.dd_take_home_site.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}


resource "aws_s3_bucket_public_access_block" "dd_take_home_site_public_access_block" {
  bucket = aws_s3_bucket.dd_take_home_site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_acl" "dd_take_home_site_bucket_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.dd_take_home_site_public_ownership_controls,
    aws_s3_bucket_public_access_block.dd_take_home_site_public_access_block
    ]

  bucket = aws_s3_bucket.dd_take_home_site.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "bucket-policy" {
  bucket = aws_s3_bucket.dd_take_home_site.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.dd_take_home_site.id}/*"
            ]
        }
    ]
})
}

resource "aws_s3_bucket_website_configuration" "dd_take_home_site_website_configuration" {
  bucket = aws_s3_bucket.dd_take_home_site.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}