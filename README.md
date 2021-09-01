# Sample Terraform code to deploy a VM on Azure

## How to use

1. Fork the repo
2. In TFC create a workspace linked to the forked repo
3. Set the below ENV VARS to the workspace for authenticating to Azure using a Service Principal and a Client Secret


```
export ARM_TENANT_ID="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export ARM_CLIENT_ID="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export ARM_CLIENT_SECRET="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export ARM_SUBSCRIPTION_ID="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

4. Start a new plan
