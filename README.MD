# 文心智能体管理平台

## 简介

文心智能体管理平台是一个基于FastAPI的多账户智能体管理平台，用于自动化管理多个文心账号的智能体。

## 功能

- 多账户管理
- 智能体管理
- 任务管理
- 登录状态检查
- 账号登录状态检查
- 账号登出
- 账号登录

## API文档

- [API文档](http://localhost:8000/docs)

## 部署

- 使用Docker部署

```bash
docker-compose up -d
```

## 使用说明
程序首次启动后会检查运行目录是否存在api.key文件，如果没有则自动生成，此文件内存储的是api-key

### api列表
如无说明，均为get方式

- /accounts
    - 获取所有的账号信息，这里是数据库的信息非实时信息
- /accounts/{id}
    - 获取指定账号实时信息并更新入库
- /accounts/login/qrcode
    - 获取登录二维码，post方式
- /accounts/login/status
    - 获取实时登录状态，同样会更新入库
- /accounts/logout
    - 登出账号，，post方式
- /accounts/check
    - 检查所有账号的登录状态，更新入库，post方式
- /create-agents
    - 创建智能体，返回任务id，post方式
- /task/{task_id}
    - 通过任务id获取任务信息
- /agents/{agent_id}
    - 更新指定智能体信息，put方式
- /agents/{account_id}/{agent_id}
    - 删除指定账号下的智能体，delete方式
- /api/key-info
    - 获取有效key的部分信息

### 操作流程

1. 获取登录二维码
2. 通过第一步返回的信息获取登录状态
3. 确认登录状态是否正确
4. 创建智能体
5. 获取创建智能体任务状态
6. 查询智能体信息
7. 更新智能体信息
8. 删除智能体