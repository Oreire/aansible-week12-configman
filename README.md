## Automated Provisioning and Deployment of Infrastructure and Application Using Terraform and Ansible on AWS

Overview:
Implemented an automated, end‑to‑end provisioning and deployment pipeline for cloud infrastructure and applications on AWS using Terraform and Ansible. The project demonstrates Infrastructure as Code (IaC) and configuration management best practices, enabling resilient, scalable, and high‑performance cloud environments. Terraform scripts provisioned AWS resources consistently across environments, while Ansible automated configuration management and application deployment. This approach reduced manual intervention, improved operational stability, and streamlined cloud resource orchestration, ensuring production‑ready deployments aligned with modern DevOps principles.



## Project Summary

Organizations today are increasingly driven by the need to develop resilient, scalable, reliable, and high-performance cloud-based applications without being burdened by the complexities of managing underlying infrastructure. This project provides hands-on experience in achieving automated infrastructure provisioning, management, and deployment in a production environment using Terraform and Ansible. By leveraging these tools, the project demonstrates how cloud resources can be efficiently orchestrated to support seamless application deployment and operational stability.

## Key steps for Project Implementation

## Prerequisites

    •	Install Terraform
    •	Install Ansible
    •	AWS CLI 
    •	Configure AWS API Secrets

## Steps to Deploy the Infrastructure

1.	Clone the Repository:

2.	Create GitHub Actions Workflow:

3.	Generate Ansible Inventory file

4.	Create and Run Ansible Playbooks

5.	Cleaning Resources (Optional)


## Project Technical Features

Particularly, this project deployed a StockMarket App, which consists of two Java backend systems and two Nginx reverse proxy servers, all hosted within a cloud infrastructure. The project was structured into three distinct levels, focusing on:

1.	## Terraform for Infrastructure Provisioning:
        
        o	Leveraged GitHub Actions pipline and utilized Terraform to automate the creation of five 
            cloud-based instances required for hosting the application.
        
        o	Modularization and Reusability for Enahnced Maintainability.
        

2.	## Ansible for Configuration Management:

        o	Configuration of provisioned AWS EC2 instances using playbooks.
        
        o	Implemented Ansible playbooks to streamline the installation and configuration of **Nginx** as a 
            **reverse proxy** and Java 17 with Maven on backend nodes.

3.	## Traffic routing:

        o	Ensuring seamless request forwarding from Nginx to the Java backend using properly configured 
            Nginx reverse proxy rules.
    

4. ## Service wrapper:

        o	Employed a service wrapper around the Java application for the effeective managemnet and control 
            of application restarts without disruption of service availability.

5.	## Seamless Integration:

        o	Terraform outputs used for the generation of the ansible inventory file using the private IP
        addresses. 

        o	Managed nodes configured with the public key of the Ansible Console node

6.	## Project Artefacts:

        o	The file for the Project deliverables has been uploaded with the repository.
        

**Conclusion**

	
The automation-driven approach employed in this project enhanced the scalability, resilience, and efficiency of the deployment, allowing the application to reliably return stock prices upon user requests.
