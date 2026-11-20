# ============================================================================
# 无服务器并发处理 - 华为云 Terraform IaC
# ============================================================================
# 架构: FunctionGraph (Node.js) 多线程处理
# ============================================================================

terraform {
  required_version = ">= 1.5"

  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = "~> 1.70"
    }
  }
}

provider "huaweicloud" {
  region = var.region
}

# ============================================================================
# 变量定义
# ============================================================================

variable "region" {
  description = "华为云区域"
  type        = string
  default     = "cn-north-4"
}

variable "project_name" {
  description = "项目名称"
  type        = string
  default     = "serverless-concurrency"
}

# ============================================================================
# FunctionGraph Application
# ============================================================================

resource "huaweicloud_fgs_application" "main" {
  name        = "${var.project_name}-app"
  description = "Serverless concurrency application"
}

# ============================================================================
# FunctionGraph 函数
# ============================================================================

resource "huaweicloud_fgs_function" "multithreading" {
  name        = "${var.project_name}-handler"
  app         = huaweicloud_fgs_application.main.name
  description = "无服务器并发处理示例"
  handler     = "index.handler"
  memory_size = 128
  timeout     = 10
  runtime     = "Node.js18"

  # 代码通过 OBS 上传，需要提前将代码打包上传
  # code_type = "obs"
  # code_url  = "https://your-bucket.obs.region.myhuaweicloud.com/functions/multithreading.zip"

  # 使用内联代码（base64 编码的 zip）
  code_type = "inline"
  func_code = base64encode("placeholder")

  lifecycle {
    ignore_changes = [func_code]
  }
}

# ============================================================================
# 输出
# ============================================================================

output "function_urn" {
  description = "FunctionGraph Function URN"
  value       = huaweicloud_fgs_function.multithreading.urn
}

output "function_id" {
  description = "FunctionGraph Function ID"
  value       = huaweicloud_fgs_function.multithreading.id
}
