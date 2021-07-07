# Savana Medical Challenger
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
    ├── policies
    ├── task-definitions
    ├── provider.tf
    ├── logs.tf
    ├── networking.tf
    ├── ecs.tf
    ├── security.tf
    ├── alb.tf
    └── variables.tf
└── Jenkins 
    └── pipeline
```

# Step 2. Built the image Docker with the "hello_world.py"
Navege in the directory in the repo

```
cd savana-challenger/app/

```

The Dockerfile in your local directory have the following code
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


