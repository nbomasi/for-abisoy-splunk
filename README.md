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

<<<<<<< HEAD
=======
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


>>>>>>> main
