### Sample Java-Tomcat helloworld app

![AyeAye](https://github.com/shippableSamples/node-build-push-docker-hub/blob/master/public/resources/images/captain.png)

# Sample Java/Tomcat app running in Docker container on Elastic Beanstalk
[![Run Status](https://api.shippable.com/projects/5885ecca11c45a1000af5760/badge?branch=master)](https://app.shippable.com/projects/5885ecca11c45a1000af5760)
[![Coverage Badge](https://api.shippable.com/projects/5885ecca11c45a1000af5760/coverageBadge?branch=master)](https://app.shippable.com/projects/5885ecca11c45a1000af5760)


A simple Java Hello World application with unit tests and coverage reports.

This repo demonstrates the following features:
* Set up serverless CI, i.e. on Shippable-provided infrastructure
* Set up CD pipelines for deploying a docker image to a Single Container Docker Configuration on Amazon Elastic Beanstalk
* Perform CI tests
* Perform Maven build to generate .war package
* Perform docker build to create Tomcat server with .war package
* Push docker image to Amazon ECR
* Automatically deploy docker image to TEST environment on Elastic Beanstalk
* Manually deploy docker image to PROD environment on Elastic Beanstalk
* Set up runCLI job types in Shippable using AWS EB CLI

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
* Follow instructions to add your [Continuous Deployment pipeline](http://docs.shippable.com/tutorials/pipelines/howToAddSyncRepos/)
* Right-click on the runCLI job in the SPOG view named 'demo-java-ecr-test-deploy' 
and run the job
  * This demo uses custom scripting jobs called 'runCLI' jobs in Shippable - 
  [learn how more about runCLI jobs here](http://docs.shippable.com/pipelines/jobs/runCLI/) 
* Your app should be deployed to your Elastic Beanstalk Test environment
  * See http://{your-IP-address}:{your-test-env-port}/HelloWorld/hello in your browser
* Right-click on the runCLI job in the SPOG view named 'demo-java-ecr-prod-deploy'
and run the job to deploy to your Prod instance
  * See http://{your-IP-address}:{your-prod-env-port}/HelloWorld/hello in your browser
* Make a change to your forked repo and commit to GitHub - watch your pipeline 
automatically execute CI with push to Amazon ECR and automatic deployment to the 
Test environment in Amazon Elastic Beanstalk
* Then right-click to deploy the newest changes to the Prod environment

Your end-to-end pipeline is complete! Now, any change you make to the application 
will be deployed to your Amazon Elastic Beanstalk Test instance and be ready to manually deploy a 
Prod instance, as well.

### CI console screenshot
![CI Console Log](https://github.com/shippableSamples/java-ecr-runcli-elasticbeanstalk/blob/master/resources/images/java-ecr-runcli-elasticbeanstalk-CI.png)

### AWS integration screenshot
![Integration View](https://github.com/shippableSamples/java-ecr-runcli-elasticbeanstalk/blob/master/resources/images/java-ecr-runcli-elasticbeanstalk-integration.png)

### CD Pipeline SPOG screenshot
![CD Pipeline](https://github.com/shippableSamples/java-ecr-runcli-elasticbeanstalk/blob/master/resources/images/java-ecr-runcli-elasticbeanstalk-CD.png)

