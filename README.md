# Flutter Chat Mini

**一个使用 `Flutter` 开发的超级简单的聊天应用**
<div align="center">

## 截图

| `登录界面` | `注册界面` |
|---|---|
| ![da4b29d00152bfcd137ffabc929fabbe](https://github.com/user-attachments/assets/79c123d2-66dc-4dc1-8462-06b7d3ae468e) | ![4E5EE7ABEC465CA4EB814485072C35A0](https://github.com/user-attachments/assets/a8ba5968-fadd-475c-bff3-0c917dbdc803) |

| `聊天界面` | `用户列表界面` |
|---|---|
| ![90B9922D6258ED764A4084EACB3ECCDB](https://github.com/user-attachments/assets/b93b9931-7aed-4ab8-a6eb-25ce62f4e8b6) | ![590A712B626652D994674676F3FF9048](https://github.com/user-attachments/assets/0aac454d-0997-4cdd-9e05-48004e5c6a42) |


</div>

**以下是应用程序使用的`数据库`表结构：**


### profiles 表
| 字段 | 类型 | 描述 |
|---|---|---|
| id | uuid | 主键 |
| email | varchar | 用户邮箱 |

### chat_message 表
| 字段 | 类型 | 描述 |
|---|---|---|
| senderEmail | varchar | 发送者邮箱 |
| receiverEmail | varchar | 接收者邮箱 |
| message | text | 消息内容 |
| timeStamp | timestamp | 时间戳 |
| chatRoomID | uuid | 聊天室 ID |

### chat_room 表
| 字段 | 类型 | 描述 |
|---|---|---|
| id | uuid | 主键 |
| user1_email | varchar | 用户1邮箱 |
| user2_email | varchar | 用户2邮箱 |

