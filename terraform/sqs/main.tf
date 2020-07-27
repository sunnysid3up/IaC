resource "aws_sns_topic" "order_placed_topic" {
  name                  = var.topic-name
  delivery_policy       = <<JSON
    {
      "http": {
        "defaultHealthyRetryPolicy": {
          "minDelayTarget": 20,
          "maxDelayTarget": 500,
          "numRetries": 5,
          "backoffFunction": "exponential"
        },
        "disableSubscriptionOverrides": false
      }
    }
  JSON
}

resource "aws_sns_topic_subscription" "order_placed_subscription" {
  topic_arn           = aws_sns_topic.order_placed_topic.arn
  protocol            = "sqs"
  endpoint            = aws_sqs_queue.main_queue.arn
}

resource "aws_sqs_queue" "main_queue" {
  name                          = var.queue-name
  redrive_policy                = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.dead_letter_queue.arn}\",\"maxReceiveCount\":5}"
  visibility_timeout_seconds    = 300
  tags                          = {Name = "main"}
}

resource "aws_sqs_queue" "dead_letter_queue" {
  name = var.dl-queue-name
}

resource "aws_sqs_queue_policy" "main_queue_policy" {
  queue_url = aws_sqs_queue.main_queue.id
  policy    = data.aws_iam_policy_document.main_queue_iam_policy.json
}

data "aws_iam_policy_document" "main_queue_iam_policy" {
  policy_id = "SQSSendAccess"
  statement {
    sid       = "SQSSendAccessStatement"
    effect    = "Allow"
    actions   = ["SQS:SendMessage"]
    resources = [aws_sqs_queue.main_queue.arn]
    principals {
      identifiers = ["*"]
      type        = "*"
    }
    condition {
      test     = "ArnEquals"
      values   = [aws_sns_topic.order_placed_topic.arn]
      variable = "aws:SourceArn"
    }
  }
}
