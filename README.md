# Example of testing C programs using RV-Match.  

[![Build Status](https://travis-ci.org/shd101wyy/undefinedness_example.svg?branch=master)](https://travis-ci.org/shd101wyy/undefinedness_example)


## Build your project with RV-Toolkit using TravisCI.  

First, log in to [TravisCI](https://travis-ci.org/) website and make sure your GitHub project is enabled like this in your profile page:  

<img width="1440" alt="screen shot 2018-05-10 at 5 13 32 pm" src="https://user-images.githubusercontent.com/1908863/39896860-80bc5122-5475-11e8-842d-d60786f7ff83.png">
 

Second, create a `.travis.yml` file under your project directory and add the following content to it:

```yaml
sudo: required  # This will request TravisCI to grant you sudo privilege.
services:
  - docker      # This will ask TravisCI for docker service.
language: c
env:
  global:
    # This is the name of the RV-Toolkit docker image that we will pull,
    # which is a Ubuntu 1604 image that has RV-Match/RV-Predict preinstalled for you,
    # so you can run several rv commands such as `kcc`, `rvpc` directly.  
    - IMAGE_NAME="runtimeverification/match-box"

    # This is the name of the docker container that we will create.
    - CONTAINER_NAME="match-box"
before_install:
  # This will download the RV-Toolkit docker image
  - docker pull "$IMAGE_NAME"

  # This will start a docker container,
  # and mount this repository directory to `/repo/`.
  - docker run --name "$CONTAINER_NAME" --volume "$PWD/":/repo/ --rm -t -d "$IMAGE_NAME" 
script:
  # This will execute `rv.sh` script within the docker container we just started in previous step.
  - docker exec -it "$CONTAINER_NAME" bash -c "cd /repo/; bash /repo/rv.sh"

  # This will stop and cleanup the docker container.
  - docker container stop "$CONTAINER_NAME"
```

After you set up your `.travis.yml`, you can then create a `rv.sh` to configure your build.
For example:  

```sh
#!/bin/sh
# This is running under Ubuntu 16.04

# Install necessary packages.  
sudo apt-get install blablabla -y 

# Build C program with RV-Match kcc command, 
# and output  `./my_errors.json` file for genreating HTML report later
kcc -fissue-report=./my_errors.json main.c

# Generate a HTML report with `rv-html-report` command,
# and output the HTML report to `./report` directlry.  
rv-html-report ./my_errors.json -o report

# Upload your HTML to RV-Toolkit website.  
rv-upload-report `pwd`/report

# Done.
```

Then every time you make a commit to repository, the TravisCI will start a build and push your HTML report to RV-Toolkit website.