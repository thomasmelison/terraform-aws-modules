# Trigger to ECS Task for S3 Event.

## What is this module?

This module provision a trigger for when an S3 event occur to trigger an ECS Task that that will run with environment variables related to the S3 event. For this module to work you need an S3 bucket, an ECS cluster with a Task Definition and a subnet to run this ECS Task.