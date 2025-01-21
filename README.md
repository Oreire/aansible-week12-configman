# aansible-week12-configman
Configuration Management of Managed Nodes using Ansible Console Node

name: Deploy AWS EC2 Instances

on:
  push:
    branches:
      - main
  workflow_dispatch:
    inputs:
      action:
        description: 'Choose action: apply or destroy'
        required: true
        default: 'apply'
        type: choice
        options:
          - apply
          - destroy

env:
  AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
  AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_KEY_ID }}
  AWS_DEFAULT_REGION: eu-west-2

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v1

      - name: Terraform Init
        run: terraform init

      - name: Terraform Format Check
        run: terraform fmt

      - name: Terraform Validate
        run: terraform validate

      - name: Terraform Plan
        id: plan
        run: terraform plan -out=plan.tfplan

      - name: Convert Terraform Output to JSON
        run:  json_output=$(terraform output -json)
        
               
      - name: Terraform Apply
        if: github.event_name == 'push' || (github.event.inputs.action == 'apply')
        run: terraform apply -auto-approve plan.tfplan

      - name: Terraform Destroy
        if: github.event.inputs.action == 'destroy'
        run: terraform destroy -auto-approve
