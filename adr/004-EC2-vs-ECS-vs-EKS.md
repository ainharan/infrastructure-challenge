# EC2 vs ECS vs EKS

## Issue
Deciding the best platform to deploy to

## Decision
We should scale with the requirements, start with a simple 3 tier app, migrate when required to either ECS or EKS depending on needs

Hence, we should choose EC2 as it is the simplest to set up and a micro instance is enough for our expected traffic

## Status
Accepted
