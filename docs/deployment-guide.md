# 部署指南

## 1. 前置条件

- 华为云账号
- Terraform CLI (>= 1.5)
- Node.js 18+ (用于打包)

## 2. 配置步骤

### 2.1 配置华为云凭据

```bash
export HW_ACCESS_KEY="your-access-key"
export HW_SECRET_KEY="your-secret-key"
export HW_REGION="cn-north-4"
```

### 2.2 打包函数代码

```bash
cd src/functions
zip -r ../../infra/function-code/multithreading.zip index.js
```

### 2.3 上传到 OBS

将生成的 zip 文件上传到 OBS 桶：

```bash
obsutil cp multithreading.zip obs://your-bucket/function-code/
```

### 2.4 更新 Terraform 配置

在 `infra/main.tf` 中更新函数的 `code_url`：

```hcl
resource "huaweicloud_fgs_function" "multithreading" {
  # ...
  code_type = "obs"
  code_url  = "https://your-bucket.obs.cn-north-4.myhuaweicloud.com/function-code/multithreading.zip"
}
```

### 2.5 部署

```bash
cd infra
terraform init
terraform validate
terraform plan
terraform apply
```

## 3. 验证部署

### 3.1 获取函数信息

```bash
terraform output function_urn
```

### 3.2 测试函数

通过华为云控制台或 API 调用 FunctionGraph 函数进行测试。

## 4. 清理资源

```bash
terraform destroy
```

## 5. 费用说明

- FunctionGraph 按调用量结算
- 具体请登录华为云控制台查询
