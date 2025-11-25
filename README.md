# Hospital of NOSO – Amazon Connect Contact Center (Terraform)

This repository automates the build-out of the **Hospital of NOSO** Amazon Connect Contact Center using Terraform.
It is designed to scale across multiple phases:

- **Phase 1:** Amazon Connect IVR + core contact center resources
- **Phase 1.5:** Prompt/config storage + voicemail storage (DynamoDB, S3) + Lambda lookup
- **Phase 3:** CI/CD using GitHub Actions (PR Plan + Manual Apply)
- **Phase 4 (future):** Amazon Lex V2 chatbot automation + Connect integration

Repo: `Groundzerro/hospital-noso-connect`

---

## Architecture Overview

**Phase 1 + 1.5 resources automated:**
- Amazon Connect Hours of Operation
- Queues (Appointments, Billing, NurseLine, Pharmacy, Operator)
- Routing Profiles
- Contact Flow Modules
- Main Inbound Contact Flow
- DynamoDB Prompts/Configs Table
- DynamoDB Voicemail Metadata Table
- S3 Voicemail Audio Bucket
- Lambda Prompt Lookup Function

---

## Repository Structure

- Root Terraform stack builds the Connect IVR + DynamoDB + S3 + Lambda
- `modules/` contains reusable Terraform modules
- `flows/` contains Amazon Connect exported JSON flows/modules
- `lambda/` contains Lambda source code
- `bootstrap_github_oidc/` is a one-time stack that creates GitHub OIDC provider + IAM role for CI/CD

---

## Prerequisites

- Terraform >= 1.5
- AWS CLI configured for the target account (initial local deploy only)
- Existing Amazon Connect instance in **us-west-2**
- Claimed phone number already attached to instance

---

## Local Deployment (Root Stack)

From repo root:

```bash
terraform init -reconfigure
terraform fmt -recursive
terraform validate
terraform plan
terraform apply


hospital-noso-connect/
├─ README.md
├─ .gitignore
├─ versions.tf
├─ providers.tf
├─ main.tf
├─ variables.tf
├─ outputs.tf
├─ terraform.tfvars
│
├─ bootstrap_github_oidc/                  # one-time CI/CD identity stack
│  ├─ versions.tf
│  ├─ main.tf
│  ├─ variables.tf
│  └─ outputs.tf
│
├─ modules/                               # reusable infra modules (Phase 1+)
│  ├─ hours_of_operation/
│  │  ├─ main.tf
│  │  ├─ variables.tf
│  │  └─ outputs.tf
│  ├─ queues/
│  │  ├─ main.tf
│  │  ├─ variables.tf
│  │  └─ outputs.tf
│  ├─ routing_profiles/
│  │  ├─ main.tf
│  │  ├─ variables.tf
│  │  └─ outputs.tf
│  ├─ contact_flow_modules/
│  │  ├─ main.tf
│  │  ├─ variables.tf
│  │  └─ outputs.tf
│  ├─ contact_flows/
│  │  ├─ main.tf
│  │  ├─ variables.tf
│  │  └─ outputs.tf
│  ├─ dynamodb_prompts/
│  │  ├─ main.tf
│  │  ├─ variables.tf
│  │  └─ outputs.tf
│  ├─ dynamodb_voicemail/
│  │  ├─ main.tf
│  │  ├─ variables.tf
│  │  └─ outputs.tf
│  ├─ s3_voicemail/
│  │  ├─ main.tf
│  │  ├─ variables.tf
│  │  └─ outputs.tf
│  └─ lambda_prompt_lookup/
│     ├─ main.tf
│     ├─ variables.tf
│     └─ outputs.tf
│
├─ flows/                                 # Connect JSON exports (Phase 1)
│  ├─ main-inbound.json
│  ├─ modules/
│  │  ├─ language-select.json
│  │  ├─ dept-menu.json
│  │  ├─ hours.json
│  │  └─ voicemail.json
│  └─ templates/                          # future .tftpl for dynamic IDs
│     └─ (empty for now)
│
├─ lambda/                                # Lambda source code
│  └─ prompt_lookup/
│     ├─ app.py
│     └─ requirements.txt                 # optional
│
└─ .github/
   └─ workflows/                          # Phase 3 CI/CD (next)
      ├─ terraform-plan.yml               # PR plan + comment
      └─ terraform-apply.yml              # manual apply (workflow_dispatch)
