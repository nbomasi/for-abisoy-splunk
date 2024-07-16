# DevOps-Pod-B-May2024-SHALI-terraform

# Initialize Github Actions CI/CD Pipeline for Terraform

# This repository contains infrastructure code managed with Terraform, with a CI/CD pipeline set up using GitHub Actions to automate the testing and deployment processes

# Description
The project aims to initialize a Github Actions CI/CD pipeline for Terraform to ensure infrastructure changes can be automated, securely executed, and controlled through manual approvals and branch restrictions. The codes in this project shows how to achieve the following.

* creation of Github Actions workflow which is committed to the repository
* Workflow configuration to trigger on push and pull request events
* Utilizing Github Secrets to securely store AWS credentials and other sensitive information.
* A manual approval step is implemented in the workflow before applying changes to production.
* The workflow ensures that terraform apply can only be executed on the main branch for production environments

# The workflow includes steps to :
    Initialize Terraform
    Validate Terraform configurations
    The workflow plans and applies Terraform changes to the "sandbox" environment when working on feature branches
    For other environments, the workflow only plans changes on feature branches but doesn't apply them

# How to trigger the pipeline
* Via GitHub Actions Interface:

    Go to the repository on GitHub.
    Click on the "Actions" tab.
    Select the workflow you want to run (e.g., ".github/workflows").
    Click the "Run workflow" button and select the branch to run the workflow on.

* Via GitHub CLI

    Install the GitHub CLI if you haven't already.
    Use the following command to trigger the workflow:
    gh workflow run <.github/workflow> --ref <branch>


# Managing the Pipeline

* Monitoring Pipeline Status
    Navigate to the "Actions" tab in the repository
    You can see the status of recent workflow runs (success, failure, in progress).
    Use the GitHub CLI to check the status of workflow runs with the command 'gh run list'

* Viewing Logs
    In the GitHub Actions interface, click on a specific workflow run to view detailed logs for each step of the pipeline

* Restarting Failed Jobs
    Navigate to the failed job.
    Click on the "Re-run jobs" button
    You can also use the following command: gh run rerun <run_id>

# Slack Notification Setup

* Create a [Slack App](https://api.slack.com/apps) for your workspace (alternatively use an existing app you have already created and installed).
* Add the [incoming-webhook](https://api.slack.com/scopes/incoming-webhook) bot scope under OAuth & Permissions.
* Install the app to your workspace (you will select a channel to notify)
* Activate and create a new webhook under Incoming Webhooks.
* Copy the Webhook URL from the Webhook you just generated [add it as a secret in your repo settings](https://docs.github.com/en/free-pro-team@latest/actions/reference/encrypted-secrets#creating-encrypted-secrets-for-a-repository) named SLACK_WEBHOOK_URL.

```
- name: Send custom JSON data to Slack workflow
  id: slack
  uses: slackapi/slack-github-action@v1.26.0
  with:
    # For posting a rich message using Block Kit
    payload: |
      {
        "text": "GitHub Action build result: ${{ job.status }}\n${{ github.event.pull_request.html_url || github.event.head_commit.url }}",
        "blocks": [
          {
            "type": "section",
            "text": {
              "type": "mrkdwn",
              "text": "GitHub Action build result: ${{ job.status }}\n${{ github.event.pull_request.html_url || github.event.head_commit.url }}"
            }
          }
        ]
      }
  env:
    SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK_URL }}
    SLACK_WEBHOOK_TYPE: INCOMING_WEBHOOK

```

# How to use tfvars Files for Different Environments in Terraform

* Create tfvars files for each environment e.g sandbox.tfvars, staging.tfvars etc and add the variables as shown below

sandbox.tfvars
```
environment   = "sandbox"
instance_type = "t2.micro"
region        = "us-west-2"

```

staging.tfvars

```
environment   = "staging"
instance_type = "t2.medium"
region        = "us-east-1"

```
* Reference the variables In in the Terraform configuration files (e.g., main.tf)
* Initialize Terraform in the project directory then preview the changes Terraform will make by using the plan command with the appropriate tfvars file.
```
terraform plan -var-file="sandbox.tfvars"
```
* Then apply the configuration for the specific environment by specifing the appropriate tfvars file for the environment.
```
terraform apply --auto-approve -var-file="sandbox.tfvars"
```


# EC2 Module Documentation
### Overview
The EC2 module can now support both standalone EC2 instances and Auto Scaling Groups (ASGs). This flexibility allows you to deploy either a single EC2 instance or a group of instances that can scale automatically based on demand.

### Variables
- **use_asg:** Boolean flag to toggle between standalone EC2 instances and Auto Scaling Groups.
- **instance_count:** Number of EC2 instances to create (only applicable when use_asg is false).
- **instance_type:** The type of instance to start (e.g., t2.micro).
- **key_name:** Key pair name to access the EC2 instances.
- **subnet_ids:** List of subnet IDs where instances or ASG will be deployed.
- **vpc_security_groups:** List of security group IDs to associate with the instances or ASG.
- **ami_name_filter:** Filter to select the AMI by name.
- **ami_owner:** The owner of the AMI.
- **desired_capacity:** Desired number of instances in the ASG (only applicable when use_asg is true).
- **min_size:** Minimum size of the ASG (only applicable when use_asg is true).
- **max_size:** Maximum size of the ASG (only applicable when use_asg is true).
- **pod:** Pod name for tagging.
- **root_volume_size:** Size of the root volume in GiB.
- **root_volume_type:** Type of the root volume (e.g., gp2 or gp3).
- **environment:** Environment name for tagging.
- **tags:** Additional tags to associate with the instances or ASG.

Conclusion
The above Terraform module and examples demonstrate how to use the use_asg variable to toggle between standalone EC2 instances and Auto Scaling Groups. By following the provided examples, you can easily deploy either a single EC2 instance or an ASG in your AWS environment. This flexibility allows for scalable and resilient infrastructure that can adapt to varying workloads.

## Changelog

This project maintains a [CHANGELOG](./CHANGELOG.md) following the [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) standard.

### Updating the Changelog

Please ensure that every change is documented in the [CHANGELOG](./CHANGELOG.md) according to our [Changelog Update Guidelines](./CHANGELOG_GUIDELINES.md).

This helps us provide a clear history of changes, improve collaboration, and assist in auditing and troubleshooting.



# TFSec Integration for terraform

[*tfsec*](https://aquasecurity.github.io/tfsec/v0.63.1/) is a static analysis security scanner for your Terraform code. Designed to run locally and in your CI pipelines, developer-friendly output and fully documented checks mean detection and remediation can take place as quickly and efficiently as possible.
### TFSec Scan Results Interpretation
TFSec generates scan results in JSON format, categorizing issues by severity levels: CRITICAL, HIGH, MEDIUM, and LOW. Each result includes:
#### Issue Description:
Details on the security issue or best practice violation detected. Severity Level: Indicates the criticality of the issue. Location: Specifies the file and line number where the issue was found.
### Interpreting Severity Levels
CRITICAL and HIGH: These issues pose significant security risks and should be addressed immediately. MEDIUM and LOW: While less critical, these issues should still be reviewed and resolved to maintain best practices and security hygiene.
### Ignoring Warnings
You may wish to ignore some warnings. If you'd like to do so, you can simply add a comment containing tfsec:ignore: to the offending line in your templates. If the problem refers to a block of code, such as a multiline string, you can add the comment on the line above the block, by itself.
For example, to ignore an open security group rule:
```
resource "aws_security_group_rule" "my-rule" {
    type = "ingress"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:aws-vpc-no-public-ingress-sgr
}
```
...or...
```
resource "aws_security_group_rule" "my-rule" {
    type = "ingress"
    #tfsec:ignore:aws-vpc-no-public-ingress-sgr
    cidr_blocks = ["0.0.0.0/0"]
}
```

