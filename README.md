### Sample Java-Tomcat helloworld app

![AyeAye](https://github.com/shippableSamples/node-build-push-docker-hub/blob/master/public/resources/images/captain.png)

# Sample Java app with deploy to Tomcat running on EC/2
[![Run Status](https://api.shippable.com/projects/5885ecca11c45a1000af5760/badge?branch=master)](https://app.shippable.com/projects/5885ecca11c45a1000af5760)
[![Coverage Badge](https://api.shippable.com/projects/5885ecca11c45a1000af5760/coverageBadge?branch=master)](https://app.shippable.com/projects/5885ecca11c45a1000af5760)


A simple Java Hello World application with unit tests and coverage reports.

This repo demonstrates the following features:
* Set up serverless CI, i.e. on Shippable-provided infrastructure
* Set up CD pipelines for a VM cluster running Tomcat on Amazon EC2
* Perform CI tests
* Perform Maven build and push war package to Amazon S3
* Automatically deploy war package to TEST environment 
* Manually deploy war package to PROD environment 
* Set up runCLI job types in Shippable using AWS CLI

## Run CI for this repo on Shippable
* Fork this repo into your source code account (e.g. GitHub)
* Create an account (or login) on [Shippable](www.shippable.com) with your SCM account
* Create an [integration](http://docs.shippable.com/integrations/imageRegistries/ecr/) 
on Shippable for authenticating CI to AWS
* Update the CI configuration in `shippable.yml` file with your integration names 
(see comments in file)

## Add Continuous Delivery pipelines to deploy to Amazon EC/2

* Pipeline configs are in `shippable.resources.yml` and `shippable.jobs.yml` 
Check these files and update config wherever the comment asks you to replace 
with your specific values
* Create an integration for a [VM cluster](http://docs.shippable.com/integrations/deploy/nodeCluster)
* Follow instructions to add your [Continuous Deployment pipeline]
(http://docs.shippable.com/tutorials/pipelines/howToAddSyncRepos/)
* Right-click on the runCLI job in the SPOG view named 'demo-war-s3-test-deploy' 
and run the job
  * This demo uses custom scripting jobs called 'runCLI' jobs in Shippable - 
  [learn how more about runCLI jobs here](http://docs.shippable.com/pipelines/jobs/runCLI/) 
* Your app should be deployed to your VM cluster representing your Test environment
  * See http://{your-IP-address}:{your-test-env-port}/HelloWorld/hello in your browser
* Follow instructions to [connect your Continuous Integration project to your 
Continuous Delivery pipelines](http://docs.shippable.com/tutorials/pipelines/connectingCiPipelines/)
* Right-click on the runCLI job in the SPOG view named 'demo-war-s3-prod-deploy'
and run the job to deploy to your Prod instance
  * See http://{your-IP-address}:{your-prod-env-port}/HelloWorld/hello in your browser
* Make a change to your forked repo and commit to GitHub - watch your pipeline 
automatically execute CI with push to Amazon S3 and automatic deployment to the 
Test environment in Amazon EC/2
* Then right-click to deploy the newest changes to the Prod environment

Your end-to-end pipeline is complete! Now, any change you make to the application 
will be deployed to your Amazon EC/2 Test instance and be ready to manually deploy a 
Prod instance, as well.

### CI console screenshot
![CI Console Log](https://github.com/shippableSamples/java-s3-runcli-ec2/blob/master/resources/images/java-s3-ec2-CI.png)

### VM node cluster integration screenshot
![Integration View](https://github.com/shippableSamples/java-s3-runcli-ec2/blob/master/resources/images/java-s3-ec2-vm-integration.png)

### CD Pipeline SPOG screenshot
![CD Pipeline](https://github.com/shippableSamples/java-s3-runcli-ec2/blob/master/resources/images/java-s3-ec2-CD.png)

### Launch Tomcat instances for this demo

A script for launching Tomcat instances on Amazon EC/2 can be found here:
https://github.com/shippableSamples/java-s3-runcli-ec2/blob/master/installTomcat.sh

Read the comments within the script for instructions.

