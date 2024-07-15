# PythonApiSolventum

[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)](https://shields.io/)

PythonApiSolventum is a Python Flask-based API that receives fake temperature readings from a sensor and persists the data to a SQLite3 database. It also provides endpoints to retrieve statistics (minimum, maximum, and average temperature) of the recorded data.

## Table of Contents

- [Getting Started](#getting-started)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Running the Application](#running-the-application)
- [API Endpoints](#api-endpoints)
- [Docker](#docker)
- [Terraform](#terraform)
- [ToDo](#todo)

## Getting Started

These instructions will help you set up the project on your local machine for development and testing purposes.

### Prerequisites

- Python 3.7 or higher
- SQLite3
- Flask
- SQLAlchemy
- Terraform

### Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/lalith93kumar/PythonApiSolventum.git
    cd PythonApiSolventum/api
    ```

2. Create a virtual environment and activate it:
    ```bash
    python3 -m venv venv
    source venv/bin/activate  # On Windows use `venv\Scripts\activate`
    ```

3. Install the required dependencies:
    ```bash
    pip install poetry
    poetry install
    ```

### Running the Application

1. Set the Flask environment variables:
    ```bash
    export FLASK_APP=app.py
    export FLASK_ENV=development
    ```

3. Run the Flask application:
    ```bash
    poetry run flask run --host=0.0.0.0
    ```

The API should now be running at `http://127.0.0.1:5000`.

### API Endpoints

#### PUT `/api/temperature`

Registers a new temperature reading.

**Request:**
```json
{
  "sensorId": "101",
  "temperature": "12",
  "time": "YYYY-MM-DD HH:MM:SS"
}
```
**Response:**

1. `200 OK` on success
3. `400 Bad Request` if the input data is invalid

#### GET `/api/stats`

Retrieves the minimum, maximum, and average temperature from the database.

**Response:**

```json
{
  "Maximum": 30,
  "Minimum": 10,
  "Average": 15
}
```

### Docker

1. Build the Docker image:
    ```bash
    docker build -t backend .
    ```

2. Run the Docker container:
    ```bash
    docker run -p 5000:5000 backend
    ```

### Terraform

To automate the infrastructure setup for this project, we use Terraform. The following instructions assume that you have Terraform installed and configured.

#### Prerequisites

- `aws config` with admin credentials
- Create s3 Bucket as name `codePipelineStateFile` 
    Note: If you find any issue with name. Please replace the bucketName in files `/terraform_code/CodePipelineRes/provider.tf` &  `/terraform_code/EcsCluster/provider.tf`
    Since terraform block supports only constant values.


#### CI\CD Pipeline Setup 

1. Add repository to AWS Codecommit.

2. Set the Code Pipeline Terraform environment variables:
    ```bash
    export AWS_DEFAULT_REGION="xxxx"
    export AWS_ACCOUNT_ID="XXXX"
    #code commit repository name
    export REPOSITORYNAME="name"
    export CLUSTERNAME="pt2"
    ```
3. Run the Terraform command to setup Code Pipeline:
    ```bash
    cd ./terraform_code/CodePipelineRes
    terraform init
    terraform plan -var "clusterName=${CLUSTERNAME}" -var "accountID=${AWS_ACCOUNT_ID}" -var "repositoryName=${REPOSITORYNAME}" -var "region=${AWS_DEFAULT_REGION}"
    
    terraform apply -var "clusterName=${CLUSTERNAME}" -var "accountID=${AWS_ACCOUNT_ID}" -var "repositoryName=${REPOSITORYNAME}" -var "region=${AWS_DEFAULT_REGION}"  --auto-approve
    ```

CI/CD Pipeline is created & stack is ECS `pt1` deployed. Try to hit the API Using LoadBalancer DNS.

#### Resource Identifications

- ECS Cluster : ${CLUSTERNAME}-testCluster
- Load Balancer : ${CLUSTERNAME}-applicationLoadBalancer
- Code Pipeline : ${REPOSITORYNAME}-pipeline
    - Stages
        - ADockerBuild
        - BTerraformPlan
        - CTerraformApply
        - DTerraformDestroy : Manual Approval requireds 

### ToDo

- Naming conventions, Typo & Code standards.
- Configure Route 53 & Certificate to endpoint for HTTPS.
- Add `tfvars` to deploy in multiple workspaces in pipeline.
- Implementation on unit test for Api. 