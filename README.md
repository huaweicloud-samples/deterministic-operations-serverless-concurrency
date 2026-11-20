# Serverless Concurrency Demo: Huawei Cloud Best Practice

![Terraform](https://img.shields.io/badge/Terraform-1.5+-7B42BC?style=flat-square)
![Huawei Cloud](https://img.shields.io/badge/Huawei-Cloud-FF6600?style=flat-square)
![FunctionGraph](https://img.shields.io/badge/FunctionGraph-Latest-blue?style=flat-square)

[中文版](./README.cn.md)

## 1. Introduction

A Node.js serverless concurrent-processing application running on Huawei Cloud. It uses a FunctionGraph function to process concurrent tasks, demonstrating parallel processing with `Promise.all`.

### 1.1 Features

- Parallel task processing
- Batch message processing
- Serverless architecture

### 1.2 Highlights

- **Serverless**: FunctionGraph — no server management
- **Concurrency**: true parallel processing with `Promise.all`
- **Logging**: centralized log management with LTS

## 2. Tech Stack

| Component | Huawei Cloud Service | Description |
|-----------|----------------------|-------------|
| Compute | FunctionGraph | Serverless function (Node.js) |
| Logging | LTS | Log service |

## 3. Prerequisites

- Huawei Cloud account
- Terraform CLI (>= 1.5)
- Node.js 18+

## 4. Quick Start

### 4.1 Clone

```bash
git clone <repository-url>
cd deterministic-operations-serverless-concurrency
```

### 4.2 Configure credentials

```bash
export HUAWEICLOUD_ACCESS_KEY="your-access-key"
export HUAWEICLOUD_SECRET_KEY="your-secret-key"
export HW_REGION="cn-north-4"
```

### 4.3 Package and deploy

```bash
# Package function code
cd src/functions
zip -r ../../infra/function-code/multithreading.zip index.js

# Deploy
cd infra
terraform init
terraform plan
terraform apply
```

## 5. Repository Layout

```
├── docs/                  # Docs
│   ├── architecture.md    # Architecture
│   └── deployment-guide.md # Deployment guide
├── infra/                 # Terraform IaC
│   └── main.tf            # Main config
├── src/                   # Function source
│   └── functions/         # FunctionGraph functions
└── README.cn.md           # Chinese docs
```

## 6. Usage

### 6.1 Invoke the function

```bash
curl -X POST https://functiongraph.cn-north-4.myhuaweicloud.com/v2/...
```

### 6.2 View logs

View function logs in the LTS console.

## 7. Code Notes

### 7.1 Parallel processing

```javascript
const workers = [];
for (let i = 0; i < NUMBER_OF_WORKERS; i++) {
    const worker = spawnWorker(i, messages, batchItemFailures);
    workers.push(worker);
}
await Promise.all(workers);
```

### 7.2 Handler signature

```javascript
exports.handler = async (event, context) => {
    // processing logic
};
```

## 8. Clean up

```bash
cd infra
terraform destroy
```

## 9. Charges

FunctionGraph is settled per invocation volume; see the console for details.

## 10. License

MIT No Attribution.

## 11. Contact

- Issues: [Issue Tracker](https://github.com/huaweicloud-samples/deterministic-operations-serverless-concurrency/issues)
