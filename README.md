# Savana Challenger
Repository where the challenge code proposed by Savana Medical is housed

# Goal
There are dockerize and deploy a simple flask app into the code in hello_world.py to Amazon Web Services with their Elastic Container Service and a secure isolated environment with only HTTPS exposed to the world, using terraform as the infrastructure code and Jenkins as de CI/CD

# Prerequisites:
You must to have intalled in your machine:
 - AWSCLI ([See how to install](http://docs.aws.amazon.com/cli/latest/userguide/installing.html))
 - Docker ([See how to install](https://docs.docker.com/engine/installation/))
 - Terraform ([See how to install](https://www.terraform.io/intro/getting-started/install.html))
 - Git ([See how to install](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git))
 - GitHub ([See how to create repo](https://docs.github.com/en/get-started/quickstart/create-a-repo))
 - Jenkins ([See how to install](https://www.jenkins.io/doc/book/installing/))


# Step 1. Git clone the repo
Clone the repository in local

```
git clone https://github.com/chemagey/savana-challenger.git

```
Your project structure should now look like this:
```
└── README.md
└── .gitignore
└── .git
└── app 
    ├── Dockerfile
    ├── hello_world.py
    └── requirements.txt
└── terraform 
    ├── policies/
    	├── ecs-instance-role-policy.json
	├── ecs-service-role-policy.json
	└── ecs-role.json
    ├── task-definitions/
        └── flask_app.json.tpl
    ├── provider.tf
    ├── logs.tf
    ├── autoscaling.tf
    ├── iam.tf
    ├── networking.tf
    ├── ecs.tf
    ├── security.tf
    ├── alb.tf
    └── variables.tf
└── Jenkins 
    └── pipeline
```

# Step 2. Built the image Docker with the "hello_world.py"
Navigate to the directory the flask app directory 

```
cd savana-challenger/app/

```

This is the Dockerfile with which we are going to build the image flask-app
```
FROM python:3.7-alpine

WORKDIR /app
COPY requirements.txt ./

RUN pip install -r requirements.txt

COPY hello_world.py .
ENV FLASK_APP hello_world.py

EXPOSE 8080

CMD flask run --host=0.0.0.0 --port=8080
```
Now built the image

```
docker build -t ecs-flask-app .

```

# Step 3. Create the repository in AWS ECR and push the image Docker
Firt create the credential with own count in AWS
```
aws configure
AWS Access Key ID [****************]:
AWS Secret Key ID [****************]:

```
Now the create the repository in ECR
```
aws ecr create-repository --repository-name ecs-flask-app

```
Authenticate the Docker CLI to use the ECR registry:
```
aws ecr get-login --region us-west-1 --no-include-email

```
Next the push image 
```
docker push 619801971185.dkr.ecr.eu-west-1.amazonaws.com/ecs-flask-app:latest

```
# Step 4. Create AWS infrastructure ECS with terraform
Navigate to the terraform directory

```
cd savana-challenger/terraform

```
Run the commands and with that we can start defining each piece of the AWS infrastructure
```
terraform init
terraform plan
terraform apply --auto-approve

```

# Bonus Challenge. Jenkins Pipeline
I have added the code to automate the whole deployment with jenkins

