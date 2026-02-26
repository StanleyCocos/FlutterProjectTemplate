# FlutterProjectTemplate

基于 Flutter 的企业级项目模板，采用 **Feature-first** 与 **Clean Architecture** 结合、Feature 内 **MVVM** 的架构。

---

## 项目架构

### 整体模式

- **Feature-first**：按业务功能划分 `features/`，每个功能自洽、可独立迭代。
- **Clean Architecture**：`data` 为共享数据层，`core` 提供领域抽象与基础设施，`features` 为展示层并依赖内层。
- **Feature 内 MVVM**：每个 feature 包含 View（页面/组件）、ViewModel（状态与业务编排）、Model（该功能实体/DTO）。

依赖方向：`features` → `core`；features 通过 `core/domain` 的 Repository 接口与数据交互，不直接依赖 `data` 实现。

### 目录结构

```
lib/
├── main.dart          # 入口：DI 初始化与 runApp(App())
├── app.dart           # 根 Widget：MaterialApp、主题、路由、Provider
├── core/              # 公共基础设施与领域抽象
│   ├── constants/     # 应用常量、API 常量
│   ├── theme/         # 主题、颜色
│   ├── router/        # 路由配置与路由名
│   ├── utils/         # 工具函数、扩展、校验器
│   ├── widgets/       # 全局通用 UI 组件（按钮、弹窗、加载等）
│   ├── errors/        # 统一异常与错误处理
│   ├── network/       # 网络客户端封装
│   └── domain/        # 跨 Feature 的领域抽象（如 Repository 接口）
├── data/              # 共享数据层
│   ├── datasources/   # 远程 API、本地存储
│   ├── models/        # DTO、JSON 序列化
│   ├── repositories/  # Repository 实现（实现 core/domain 接口）
│   └── di/            # 数据层依赖注入
└── features/          # 业务功能模块
    └── [feature]/
        ├── presentation/
        │   ├── view/       # 页面与 Feature 内组件
        │   └── viewmodel/  # 状态与业务逻辑
        └── models/         # 仅本 Feature 使用的模型（可选）
```

### 各层职责

| 层级 | 职责 |
|------|------|
| **core** | 常量、主题、路由、工具、通用组件、错误处理、网络配置；`domain/` 下定义 Repository 等接口，由 data 实现。 |
| **data** | 实现 core 的接口；封装 remote/local 数据源、DTO、Repository 实现与 DI。 |
| **features** | 仅依赖 core（含 domain 接口）；每个 feature 内 View 消费 ViewModel，ViewModel 调用 Repository 接口，不引用 data 包。 |

### 数据流示意

```
View ←→ ViewModel → core/domain(Repository 接口)
                         ↑
                    data/repositories(实现)
                         ↑
                    datasources + models
```

---

## 运行与测试

```bash
flutter pub get
flutter run
flutter test
```