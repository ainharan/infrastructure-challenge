# Why NAT Gateway?

## Issue
If your application (EC2 instance) needs to initiate an outbound connection to the internet (e.g., to fetch data from an external API, download software updates, interact with AWS S3, etc.), the request originates from the private subnet.

## Decision
Calls to ECR are considered outbound, so to ensure that our instance is not in the public subnet we require a NAT gateway.

Further, although the example is just a static html application, this POC is made for other docker apps to be deployed the same way.

Hence, a NAT gateway is required to allow for outbound network calls.

## Status
Accepted
