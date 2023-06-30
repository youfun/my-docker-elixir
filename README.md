# docker-elixir

由 [`@elixircn-dev`](https://github.com/elixircn-dev) 维护的 Docker 镜像。

## 介绍

此仓库维护的镜像是为本组织旗下的项目提供构建和运行基础，同时也为广大 Elixir 开发者提供多个官方镜像之外的新选择。

## 版本

此仓库通常只维护最新的两个次要版本 (MINOR)，如当前的 1.15 和 1.14。此仓库的镜像仅建立在本组织所依赖的基础镜像之上，当前主要以 Debian (`-slim`) 和 Alpine (`-alpine`)。

>由于 Docker Hub 限制了自动构建功能的使用，所以此仓库的镜像是在 CI 服务器上构建并推送的。

## 使用

拉取最新的镜像:

```bash
docker pull elixircn/elixir:1.15-otp-26-slim
```

也可以不包含任何标签，默认会拉取最新的版本（**包括 RC 版本**）。此外，您还可以使用带有具体的修订版本的镜像标签，例如 `1.15.1-otp-26-slim`。

## 支持的标签和各自的 `Dockerfile` 链接

- [`1.15.1-otp-26-slim`, `1.15-otp-26-slim`, `latest`](https://github.com/elixircn-dev/docker-elixir/blob/main/1.15/otp-26-slim/Dockerfile)
- [`1.15.1-otp-26-alpine`, `1.15-otp-26-alpine`](https://github.com/elixircn-dev/docker-elixir/blob/main/1.15/otp-26-alpine/Dockerfile)
- [`1.14.5-otp-26-slim`, `1.14-otp-26-slim`](https://github.com/elixircn-dev/docker-elixir/blob/main/1.14/otp-26-slim/Dockerfile)
- [`1.14.5-otp-26-alpine`, `1.14-otp-26-alpine`](https://github.com/elixircn-dev/docker-elixir/blob/main/1.14/otp-26-alpine/Dockerfile)

## 本地构建

拉取本项目到本地，执行 `build.exs` 脚本可快速构建和测试你需要的镜像。

命令语法：`elixir build.exs [version] [base]`，其中 `version` 表示 Elixir 的版本，而 `base` 表示基础镜像。

例子：构建基于 `otp-26-slim` 的 `1.15` 版本镜像：

```bash
elixir build.exs 1.15 otp-26-slim
```

如果输出 `Version testing ok` 就表示构建并测试成功，镜像以 `local` 作为组织名。

## 优势

与官方镜像不同，此仓库维护的镜像基于更具体的 Erlang 版本，例如 `26.0` 而不是 `26`。 所以当 Erlang 发布新的次要版本时，我们将更新所有的镜像。简而言之，此仓库维护的镜像中的 Erlang 版本更加具体且始终是最新的。

在未来，我们可能维护自己的 Erlang 镜像，并基于这些 Erlang 镜像构建 Elixir 镜像。
