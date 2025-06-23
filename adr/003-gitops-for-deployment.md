# Gitops for deployment

## Issue
Robust CI/CD requires time to build correctly, especially considering a security hardened set up.

## Decision
Split work into sizeable chunks with different timelines.
1. Push Docker image to ECR
   - simple isolated work can be used as POC for rest
   - triggers on change to docker directory
2. Terraform pipeline
   - includes tflint check
   - includes tfsec check

## Status
Accepted
