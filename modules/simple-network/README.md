# Simple Network Module

## What is this module?

This module provision an AWS network using terraform modules. This network can be deployed at many availability zones and, for each availability zone, the module provision a public subnet and a private subnet. The public subnets have internet access through an internet gateway and the private subnets have internet access through a nat gateway.