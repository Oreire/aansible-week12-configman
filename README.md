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
  AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
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
        run: |
          terraform output -json > output.json
          cat output.json  # Output the content for debugging
    
      - name: Confirm Destroy 
        if: github.event.inputs.action == 'destroy'
        run: | 
          echo "You are about to destroy the infrastructure. Are you sure you want to continue?" 
          echo "Please confirm by setting the CONFIRM_DESTROY environment variable to 'yes'." 
          if [ "${{ secrets.CONFIRM_DESTROY }}" != "yes" ]; then 
            echo "Destroy action not confirmed. Exiting." 
            exit 1 
          fi
                       
      - name: Terraform Apply
        if: github.event_name == 'push' || (github.event.inputs.action == 'apply')
        run: terraform apply -auto-approve plan.tfplan

      - name: Terraform Destroy
        if: github.event.inputs.action == 'destroy'
        run: terraform destroy -auto-approve


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
        default: 'destroy'
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
        run: |
          terraform output -json > output.json
          cat output.json  # Output the content for debugging
    
      - name: Confirm Destroy 
        if: github.event.inputs.action == 'destroy' 
        run: | 
          echo "You are about to destroy the infrastructure. Are you sure you want to continue?" 
          echo "Please confirm by setting the CONFIRM_DESTROY environment variable to 'yes'." 
          if [ "$CONFIRM_DESTROY" != "yes" ]; then 
            echo "Destroy action not confirmed. Exiting." 
            exit 1 
          fi
                       
      - name: Terraform Apply
        if: github.event_name == 'push' || (github.event.inputs.action == 'apply')
        run: terraform apply -auto-approve plan.tfplan

      - name: Terraform Destroy
        if: github.event.inputs.action == 'destroy'
        run: terraform destroy -auto-approve
