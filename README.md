# Rock-Paper-Scissor
Demo webapp for simulating rock paper scissor

# Quick Start
- Access the application deployed on AWS EKS:
    - curl -X GET `http://aaa9711e9022e44e1acabcbe8c54360d-1068681464.us-east-1.elb.amazonaws.com/{your-input}`.
    - Replace `your-input` with any random string of your choice.
- Run locally:
    - Execute `make run` from repo's root directory:
        - Runs tests
        - Build docker image
        - Runs a docker container on local machine.

        - Flags:
            - `ARCH`: archictecture of of local machine [`amd64` or `arm64`]
            - `PORT`: Host machine port to used for serving the app, defaults to 8000

# Application description:
- Used python module [create-flask-app](https://pypi.org/project/create-flask-app/) to create basic flask app structure.
- Add logic in `app/rps/__init__.py`.
    - Generate hash using prime number exponentiation.
    - Reduce to R/P/S using modulo 3
- Use Dockerfile to generate image for the application
- The image when runs starts serving on container port `12000` and accepts request from all hosts `(0.0.0.0)`.

## Testing

- Generate output from the app for any random string.
- The output should remain same for if we request the app with the same random string.
- Verify if the output is same or not. For more details please follow `tests/` directory

# Github Workflow
- `.github/workflow` directory contains a github workflow yaml to generate a CI piepline for this repo.
- It has 2 stages
    - Test: Runs the test
    - Build and Push: Build image for the application and pushes to dockerhub

# Deploying on AWS EKS using terraform
- `terraform/` directory contains all the files to create a k8s cluster on AWS EKS. 
    - Dependecies:
        - AWS CLI
        - AWS config set local machine `(~/.aws/*)`
- K8s resources are also deployed using terraform. Resource manifest present in `terraform/main.tf`.
- Resources deployed:
    - Deployment
        - image: shprakas/rps-amd:main-d3de255
        - replicas: 3 (for High Availability)
    - Service type LoadBalancer
        - Deploys a public facing AWS ELB for accessing app.



