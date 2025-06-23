# dockerised app vs native app


## Issue
Deployments should be reproducible. We should have a consistent method of control, and have reproducible builds. One CI/CD pattern that does this is [3 musketeers Pattern](https://3musketeers.pages.dev/guide/). Or some form of repeatable + declarable gitops.

## Decision
Use docker for application, but do not complicate the build process yet.

The project is small and doesn't require complicated gitops. This repo is meant to be a POC for larger applications hence the containerisation to standardize.

## Status
Accepted
