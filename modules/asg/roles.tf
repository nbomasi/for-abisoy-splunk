resource "aws_iam_role" "prometheus_grafana_role" {
  name = "prometheus-grafana-role"

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF

  tags = {
    Name = "prometheus-grafana-role"
  }
}

resource "aws_iam_policy_attachment" "prometheus_grafana_policy" {
  name       = "prometheus-grafana-attach-policy"
  roles      = [aws_iam_role.prometheus_grafana_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess" # Example policy
}
