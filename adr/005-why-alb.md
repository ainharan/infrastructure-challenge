# Why ALB?

## Issue
Need a method to route http/https traffic

## Decision
ALB has HTTP/HTTPS routing, SSL termination, sticky sessions, health checks, and path-based routing capabilities.

It also helps scale as it offloads SSL complexity from application, simplifies certificate management via AWS ACM, improves performance

## Status
Accepted
