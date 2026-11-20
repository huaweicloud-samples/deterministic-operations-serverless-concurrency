# 架构说明

## 1. 架构概述

本项目是一个基于 Node.js 的无服务器多线程处理应用程序，运行在华为云上。应用程序使用 FunctionGraph 函数处理并发任务。

## 2. 架构图

```
┌─────────────────────────────────────────────────────────────────────┐
│                         华为云                                    │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│   ┌──────────────┐     ┌──────────────────────────┐           │
│   │  APIG       │────▶│   FunctionGraph          │           │
│   │ (可选)      │     │   (Node.js 多线程)       │           │
│   └──────────────┘     └────────────┬─────────────┘           │
│                                     │                          │
│                                     ▼                          │
│                             ┌───────────────┐                  │
│                             │     LTS      │                  │
│                             │  (日志服务)  │                  │
│                             └───────────────┘                  │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

## 3. 组件说明

### 3.1 FunctionGraph

- **作用**: 执行多线程处理任务
- **Runtime**: Node.js 18.x
- **超时**: 10 秒
- **内存**: 128 MB

### 3.2 LTS

- **作用**: 日志服务，集中采集与检索函数日志

## 4. 并发处理

使用 Promise.all 实现多线程并发处理：

```javascript
const workers = [];
for (let i = 0; i < NUMBER_OF_WORKERS; i++) {
    const worker = spawnWorker(i, messages, batchItemFailures);
    workers.push(worker);
}
await Promise.all(workers);
```

## 5. 部署说明

部署使用 Terraform IaC，详情见 `infra/` 目录。

## 6. 注意事项

1. **Runtime 版本**: 使用 Node.js 18.x (FunctionGraph 支持)
2. **Handler 转换**: 原 ES Modules 改为 CommonJS exports.handler
3. **代码打包**: 需要将 index.js 打包为 zip 上传到 OBS
