resource "aws_dynamodb_table" "email-track-dynamodb-table" {
  name         = "email_track"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"
  attribute {
    name = "id"
    type = "N"
  }
}