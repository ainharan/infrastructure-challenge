# Security Group Strategy

## Issue
Security Groups should be used strategically to enforce least-privilege access

## Decision
Separate security groups for ALB and EC2 instances to enforce least-privilege access

ALB SG allows public access, EC2 SG only allows access from ALB SG

## Status
Accepted
