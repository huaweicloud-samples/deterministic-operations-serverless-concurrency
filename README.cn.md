# 无服务器并发处理示例：华为云最佳实践

![Terraform](https://img.shields.io/badge/Terraform-1.5+-7B42BC?style=flat-square)
![Huawei Cloud](https://img.shields.io/badge/Huawei-Cloud-FF6600?style=flat-square)
![FunctionGraph](https://img.shields.io/badge/FunctionGraph-Latest-blue?style=flat-square)

[English](./README.md)

## 1. 简介

这是一个基于 Node.js 的无服务器并发处理应用程序，运行在华为云上。应用程序使用 FunctionGraph 函数处理并发任务，演示了如何使用 Promise.all 实现并行处理。

### 1.1 功能特性

- 并行任务处理
- 批量消息处理
- 无服务器架构

### 1.2 架构亮点

- **无服务器**: 使用 FunctionGraph，无需管理服务器
- **并发处理**: 使用 Promise.all 实现真正的并行处理
- **日志**: LTS 集中日志管理

## 2. 技术栈

| 组件 | 华为云服务 | 说明 |
|------|------------|------|
| 计算 | FunctionGraph | 无服务器函数 (Node.js) |
| 日志 | LTS | 日志服务 |

## 3. 前置条件

- 华为云账号
- Terraform CLI (>= 1.5)
- Node.js 18+

## 4. 快速开始

### 4.1 克隆仓库

```bash
git clone <repository-url>
cd deterministic-operations-serverless-concurrency
```

### 4.2 配置凭据

```bash
export HUAWEICLOUD_ACCESS_KEY="your-access-key"
export HUAWEICLOUD_SECRET_KEY="your-secret-key"
export HW_REGION="cn-north-4"
```

### 4.3 打包并部署

```bash
# 打包函数代码
cd src/functions
zip -r ../../infra/function-code/multithreading.zip index.js

# 部署
cd infra
terraform init
terraform plan
terraform apply
```

## 5. 目录结构

```
├── docs/                  # 文档
│   ├── architecture.md    # 架构说明
│   └── deployment-guide.md # 部署指南
├── infra/                 # Terraform IaC
│   └── main.tf          # 主配置
├── src/                  # 函数源代码
│   └── functions/       # FunctionGraph 函数
└── README.md            # 英文版说明
```

## 6. 使用方法

### 6.1 调用函数

部署后通过华为云控制台或 API 调用函数：

```bash
# 通过 FunctionGraph API 调用
curl -X POST https://functiongraph.cn-north-4.myhuaweicloud.com/v2/...
```

### 6.2 查看日志

通过 LTS 查看函数日志：

```bash
# 在华为云控制台 LTS 服务中查看
```

## 7. 代码说明

### 7.1 并行处理

使用 Promise.all 实现并行：

```javascript
const workers = [];
for (let i = 0; i < NUMBER_OF_WORKERS; i++) {
    const worker = spawnWorker(i, messages, batchItemFailures);
    workers.push(worker);
}
await Promise.all(workers);
```

### 7.2 Handler 签名

华为云 FunctionGraph 使用 CommonJS 格式：

```javascript
exports.handler = async (event, context) => {
    // 处理逻辑
};
```

## 8. 清理

```bash
cd infra
terraform destroy
```

## 9. 费用说明

FunctionGraph 按调用量结算，具体请登录华为云控制台查询。

## 10. 许可证

本项目基于 MIT No Attribution 许可证。

## 11. 联系方式

- 问题反馈: [Issue Tracker](https://github.com/huaweicloud-samples/deterministic-operations-serverless-concurrency/issues)
