# IaC 01 Ingestion

# working directory
cd iac-data-aws-arbarros/01-data-ingestion
# create aws lambda
pip3 install -r functions/insert_into_mysql/requirements.txt -t lambda_layer/python
zip -r lambda_layer/python.zip lambda_layer/python

# delete folder python 
rm -rf lambda_layer/python

# terraform directory
cd terraform

# init terraform
terraform init

# see the execution plan
terraform plan

# When you run Terraform, it'll pick up the secrets automatically
terraform apply

# Variables for MySQL RDS Terraform
export TF_VAR_username="admin"
export TF_VAR_password="admin123"
```

