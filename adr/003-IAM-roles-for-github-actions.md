# Gitops for deployment

## Issue
Pipelines should assume an [IAM roles to connect to Github actions via OIDC](https://aws.amazon.com/blogs/security/use-iam-roles-to-connect-github-actions-to-actions-in-aws/)

## Decision
For simplicity, I used access_key/secret_keys to run pipelines. This has the obvious disadvantage of required key-rotation and potential of compromise.

Because this is a POC and short on time, this was out of scope

## Status
Rejected
