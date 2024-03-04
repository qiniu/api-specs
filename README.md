# Qiniu API Specs

致力于用 YAML 描述文件描述七牛公开 API 的接口，并方便应用程序解析，以便于自动生成客户端 SDK 代码。

### 数据结构

#### **`ApiDetailedDescription`**

API 描述信息

| 字段名称           | 类型                     | 描述         |
| ----------------- | ------------------------ | ------------ |
| `camel_case_name` | `String`                 | 驼峰命名     |
| `snake_case_name` | `String`                 | 下划线命名   |
| `method`          | `Method`                 | HTTP 方法    |
| `service_names`   | `[ServiceName]`          | 七牛服务名称 |
| `documentation`   | `String`                 | API 文档     |
| `base_path`       | `String`                 | URL 基础路径 |
| `path_prefix`     | `String`                 | URL 路径后缀 |
| `command`         | `String`                 | URL 查询命令 |
| `request`         | `ApiRequestDescription`  | 调用参数     |
| `response`        | `ApiResponseDescription` | 响应参数     |

#### **`ApiRequestDescription`**

API 调用参数

| 字段名称        | 类型                    | 描述             |
| --------------- | ----------------------- | ---------------- |
| `path_params`   | `Option<PathParams>`    | URL 路径参数列表 |
| `header_names`  | `Option<[HeaderName]>`  | HTTP 头参数列表  |
| `query_names`   | `Option<[QueryName]>`   | URL 查询参数列表 |
| `body`          | `Option<RequestBody>`   | 请求体           |
| `authorization` | `Option<Authorization>` | 鉴权参数         |
| `idempotent`    | `Idempotent`            | 幂等性           |

#### **`RequestBody`** 枚举类型

请求体

| 字段名称              | 值类型                           | 描述                                   |
| --------------------- | -------------------------------- | -------------------------------------- |
| `json`                | `JsonType`                       | JSON 类型                              |
| `form_urlencoded`     | `FormUrlencodedRequestStruct`    | URL 编码表单调用（无法上传二进制数据） |
| `multipart_form_data` | `MultipartFormDataRequestStruct` | 复合表单调用（可以上传二进制数据）     |
| `binary_data`         | 无                               | 二进制数据                             |

#### **`ApiResponseDescription`**

API 响应参数

| 字段名称       | 类型                   | 描述            |
| -------------- | ---------------------- | --------------- |
| `header_names` | `Option<[HeaderName]>` | HTTP 头参数列表 |
| `body`         | `Option<ResponseBody>` | 响应体          |

#### **`ResponseBody`** 枚举类型

请求体

| 字段名称      | 值类型     | 描述       |
| ------------- | ---------- | ---------- |
| `json`        | `JsonType` | JSON 类型  |
| `binary_data` | 无         | 二进制数据 |

#### **`Method`** 枚举类型

HTTP 方法

| 字段名称 | 值类型 | 描述        |
| -------- | ------ | ----------- |
| `get`    | 无     | GET 方法    |
| `post`   | 无     | POST 方法   |
| `put`    | 无     | PUT 方法    |
| `delete` | 无     | DELETE 方法 |

#### **`ServiceName`** 枚举类型

七牛服务名称

| 字段名称 | 值类型 | 描述             |
| -------- | ------ | ---------------- |
| `up`     | 无     | 上传服务         |
| `io`     | 无     | 下载服务         |
| `uc`     | 无     | 存储空间管理服务 |
| `rs`     | 无     | 对象管理服务     |
| `rsf`    | 无     | 对象列举服务     |
| `api`    | 无     | API 服务         |
| `s3`     | 无     | S3 服务          |

#### **`Idempotent`** 枚举类型

幂等性

| 字段名称  | 值类型 | 描述                             |
| --------- | ------ | -------------------------------- |
| `default` | 无     | 默认幂等性（根据 HTTP 方法判定） |
| `always`  | 无     | 总是幂等                         |
| `never`   | 无     | 总是不幂等                       |

#### **`Authorization`** 枚举类型

鉴权方式

| 字段名称       | 值类型 | 描述                  |
| -------------- | ------ | --------------------- |
| `qbox`         | 无     | 使用 QBox 签名鉴权    |
| `qiniu`        | 无     | 使用 Qiniu 签名鉴权   |
| `upload_token` | 无     | 使用 UpToken 签名鉴权 |

#### **`StringLikeType`** 枚举类型

类字符串参数类型

| 字段名称  | 值类型 | 描述       |
| --------- | ------ | ---------- |
| `string`  | 无     | 字符串     |
| `integer` | 无     | 整型数字   |
| `float`  | 无     | 浮点型数字 |
| `boolean`  | 无     | 布尔值     |

#### **`OptionalType`** 枚举类型

可选字段类型

| 字段名称  | 值类型 | 描述       |
| --------- | ------ | ---------- |
| `keepempty` | 无     | 即使用户不传值，也会发送空值   |
| `omitempty` | 无     | 如果用户不传值，则该字段省略   |
| `nullable`  | 无     | 如果用户不传值，则该字段省略，但如果用户传值，即使是空值也会发送   |

#### **`PathParams`**

URL 路径请求参数列表

| 字段名称 | 类型               | 描述                 |
| -------- | ------------------ | -------------------- |
| `named`  | `[NamedPathParam]` | URL 路径有名参数列表 |
| `free`   | `FreePathParams`   | URL 路径自由参数列表 |

#### **`NamedPathParam`**

URL 路径有名请求参数

| 字段名称        | 类型                  | 描述                                                      |
| --------------- | ---------------------- | --------------------------------------------------------- |
| `path_segment`  | `Option<String>`       | URL 路径段落，如果为空，则表示参数直接追加在 URL 路径末尾 |
| `field_name`    | `String`               | URL 路径参数名称                                          |
| `field_camel_case_name` | `String`       | URL 路径参数驼峰命名     |
| `field_snake_case_name` | `String`       | URL 路径参数下划线命名   |
| `type`          | `StringLikeType`       | URL 路径参数类型                                          |
| `documentation` | `String`               | URL 路径参数文档                                          |
| `encode`        | `Option<EncodeType>`   | URL 路径参数编码方式，如果为空，表示直接转码成字符串      |
| `optional`      | `Option<OptionalType>` | URL 路径参数是否可选，如果为空，则表示必填      |

#### **`FreePathParams`**

URL 路径自由请求参数

| 字段名称             | 类型                 | 描述                                                   |
| -------------------- | -------------------- | ------------------------------------------------------ |
| `field_name`         | `String`             | URL 路径参数名称                                       |
| `field_camel_case_name`  | `String`         | URL 路径参数驼峰命名                                    |
| `field_snake_case_name`  | `String`         | URL 路径参数下划线命名                                  |
| `documentation`      | `String`             | URL 路径参数文档                                       |
| `encode_param_key`   | `Option<EncodeType>` | URL 路径参数键编码方式，如果为空，表示直接转码成字符串 |
| `encode_param_value` | `Option<EncodeType>` | URL 路径参数值编码方式，如果为空，表示直接转码成字符串 |

#### **`EncodeType`** 枚举类型

字符串编码类型

| 字段名称                  | 值类型 | 描述                                             |
| ------------------------- | ------ | ------------------------------------------------ |
| `url_safe_base64`         | 无     | 需要进行编码                                     |
| `url_safe_base64_or_none` | 无     | 不仅需要编码，即使路径参数的值是 `None` 也要编码。该选项暗示了 `nullable` |

#### **`HeaderName`**

HTTP 头参数信息

| 字段名称        | 类型     | 描述            |
| --------------- | -------- | --------------- |
| `field_name`    | `String` | HTTP 头参数名称 |
| `field_camel_case_name`  | `String` | HTTP 头参数驼峰命名  |
| `field_snake_case_name`  | `String` | HTTP 头参数下划线命名 |
| `header_name`   | `String` | HTTP 头名称     |
| `documentation` | `String` | HTTP 头参数文档 |
| `optional`      | `Option<OptionalType>` | HTTP 头参数是否可选，如果为空，则表示必填      |

#### **`QueryName`**

URL 查询请求参数信息

| 字段名称        | 类型             | 描述             |
| --------------- | ---------------- | ---------------- |
| `field_name`    | `String`         | 参数名称         |
| `field_camel_case_name`  | `String` | URL 路径参数驼峰命名 |
| `field_snake_case_name`  | `String` | URL 路径参数下划线命名 |
| `query_name`    | `String`         | URL 查询参数名称 |
| `documentation` | `String`         | URL 查询参数文档 |
| `query_type`    | `StringLikeType` | URL 查询参数类型 |
| `optional`      | `Option<OptionalType>` | URL 查询参数是否可选，如果为空，则表示必填      |

#### **`FormUrlencodedRequestStruct`**

URL 编码表单请求结构体

| 字段名称 | 类型                           | 描述                 |
| -------- | ------------------------------ | -------------------- |
| `fields` | `[FormUrlencodedRequestField]` | URL 编码表单字段列表 |

#### **`FormUrlencodedRequestField`**

URL 编码表单请求字段

| 字段名称        | 类型             | 描述                             |
| --------------- | ---------------- | -------------------------------- |
| `field_name`    | `String`         | URL 编码表单字段名称             |
| `field_camel_case_name`  | `String` | URL 编码表单字段驼峰命名 |
| `field_snake_case_name`  | `String` | URL 编码表单字段下划线命名 |
| `key`           | `String`         | URL 编码表单参数名称             |
| `documentation` | `String`         | URL 编码表单参数文档             |
| `type`          | `StringLikeType` | URL 编码表单参数类型             |
| `multiple`      | `bool`           | URL 编码表单参数是否可以有多个值 |
| `optional`      | `Option<OptionalType>` | URL 编码表单参数是否可选，如果为空，则表示必填      |

#### **`MultipartFormDataRequestStruct`**

复合表单请求结构体

| 字段名称       | 类型                                         | 描述                 |
| -------------- | -------------------------------------------- | -------------------- |
| `named_fields` | `[NamedMultipartFormDataRequestField]`       | 有名复合表单字段列表 |
| `free_fields`  | `Option<FreeMultipartFormDataRequestFields>` | 自由复合表单字段列表 |

#### **`NamedMultipartFormDataRequestField`**

有名复合表单请求字段

| 字段名称        | 类型                           | 描述             |
| --------------- | ------------------------------ | ---------------- |
| `field_name`    | `String`                       | 复合表单字段名称 |
| `field_camel_case_name`  | `String` | 复合表单字段驼峰命名 |
| `field_snake_case_name`  | `String` | 复合表单字段下划线命名 |
| `key`           | `String`                       | 复合表单参数名称 |
| `documentation` | `String`                       | 复合表单参数文档 |
| `type`          | `MultipartFormDataRequestType` | 复合表单参数类型 |
| `optional`      | `Option<OptionalType>`         | 复合表单参数是否可选，如果为空，则表示必填      |

#### **`FreeMultipartFormDataRequestFields`**

自由复合表单请求字段

| 字段名称        | 类型     | 描述             |
| --------------- | -------- | ---------------- |
| `field_name`    | `String` | 复合表单字段名称 |
| `field_camel_case_name`  | `String` | 复合表单字段驼峰命名 |
| `field_snake_case_name`  | `String` | 复合表单字段下划线命名 |
| `documentation` | `String` | 复合表单参数文档 |

#### **`MultipartFormDataRequestType`** 枚举类型

复合表单字段请求类型

| 字段名称       | 值类型 | 描述             |
| -------------- | ------ | ---------------- |
| `string`       | 无     | 字符串           |
| `binary_data`  | 无     | 二进制数据       |
| `upload_token` | 无     | 使用上传凭证鉴权 |

#### **`JsonType`** 枚举类型

JSON 字段类型

| 字段名称     | 值类型       | 描述               |
| ------------ | ------------ | ------------------ |
| `string`     | 无           | 字符串             |
| `integer`    | 无           | 整型数字           |
| `float`      | 无           | 浮点型数字         |
| `bool`       | 无           | 布尔值             |
| `array`      | `JsonArray`  | 数组               |
| `struct`     | `JsonStruct` | 结构体             |
| `any`        | 无           | 任意数据结构       |
| `string_map` | 无           | 任意字符串映射结构 |

#### **`JsonArray`**

JSON 数组字段信息

| 字段名称        | 类型       | 描述              |
| --------------- | ---------- | ----------------- |
| `name`          | `String`   | JSON 数组名称     |
| `camel_case_name`  | `String` | JSON 数组驼峰命名 |
| `snake_case_name`  | `String` | JSON 数组下划线命名 |
| `documentation` | `String`   | JSON 数组参数文档 |
| `type`          | `JsonType` | JSON 数组类型     |

#### **`JsonStruct`**

JSON 结构体

| 字段名称        | 类型          | 描述                |
| --------------- | ------------- | ------------------- |
| `name`          | `String`      | JSON 结构体名称     |
| `camel_case_name`  | `String` | JSON 结构体驼峰命名 |
| `snake_case_name`  | `String` | JSON 结构体下划线命名 |
| `documentation` | `String`      | JSON 结构体参数文档 |
| `fields`        | `[JsonField]` | JSON 字段列表       |

#### **`JsonField`**

JSON 结构体字段

| 字段名称        | 类型                    | 描述                  |
| --------------- | ----------------------- | --------------------- |
| `field_name`    | `String`                | JSON 字段名称         |
| `field_camel_case_name`  | `String` | JSON 字段驼峰命名 |
| `field_snake_case_name`  | `String` | JSON 字段下划线命名 |
| `key`           | `String`                | JSON 字段参数名称     |
| `documentation` | `String`                | JSON 字段参数文档     |
| `type`          | `JsonType`              | JSON 字段类型         |
| `optional`      | `Option<OptionalType>`  | 复合表单参数是否可选，如果为空，则表示必填 |

## 联系我们

- 如果需要帮助，请提交工单（在portal右侧点击咨询和建议提交工单，或者直接向 support@qiniu.com 发送邮件）
- 如果有什么问题，可以到问答社区提问，[问答社区](http://qiniu.segmentfault.com/)
- 更详细的文档，见[官方文档站](http://developer.qiniu.com/)
- 如果发现了bug， 欢迎提交 [Issue](https://github.com/qiniu/rust-sdk/issues)
- 如果有功能需求，欢迎提交 [Issue](https://github.com/qiniu/rust-sdk/issues)
- 如果要提交代码，欢迎提交 [Pull Request](https://github.com/qiniu/rust-sdk/pulls)
- 欢迎关注我们的[微信](https://www.qiniu.com/contact) [微博](http://weibo.com/qiniutek)，及时获取动态信息。

## 代码许可

This project is licensed under the [MIT license].

[MIT license]: https://github.com/qiniu/rust-sdk/blob/master/LICENSE

