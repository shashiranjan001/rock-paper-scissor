# Rock-Paper-Scissor
- Demo webapp for simulating rock paper scissor
- Repo: `https://github.com/shashiranjan001/rock-paper-scissor`
    - The above repository is private

# Quick Start
- Access application deployed on AWS EKS:
    - curl -X GET `http://aaa9711e9022e44e1acabcbe8c54360d-1068681464.us-east-1.elb.amazonaws.com/{your-input}`.
    - Replace `{your-input}` with any random string of your choice.
- Run locally:
    - Execute `make run` from repo's root directory:
        - Runs tests
        - Build docker image
        - Runs a docker container on local machine.

        - Flags:
            - `ARCH`: archictecture of of local machine [`amd64` or `arm64`]
            - `PORT`: Host machine port to be used for serving the application, defaults to 8000

# Application description:
- Used python module [create-flask-app](https://pypi.org/project/create-flask-app/) to create basic flask application structure.
- Add logic in `app/rps/__init__.py`.
    - Generate hash using prime number exponentiation.
    - Reduce to Rock/Paper/Scissor using modulo 3.
- Use Dockerfile to generate image for the application.
- The image when run starts serving on container port `12000` and accepts request from all hosts `(0.0.0.0)`.

## Testing

- Generate output from the application for any random string.
- The output should remain same if we request the application with the same random string.
- Verify if the output is same or not. For more details please follow `tests/` directory

# Github Workflow
- `.github/workflow` directory contains a github workflow file to generate a CI pipeline for the application.
- It has 2 stages
    - Test: Runs the test.
    - Build and Push: Builds image for the application and pushes to dockerhub.

# Deploying on AWS EKS using terraform
- `terraform/` directory contains all the files required to create a k8s cluster on AWS EKS. 
    - Dependencies:
        - AWS CLI
        - AWS config set on local machine usually at `(~/.aws/*)`
- K8s resources are also deployed using terraform. Resources's manifests are located in `terraform/main.tf`.
- Resources deployed:
    - Deployment
        - image: shprakas/rps-amd:main-d3de255
        - replicas: 3 (for High Availability)
    - Service type LoadBalancer
        - Deploys a public facing AWS ELB for accessing the application.



