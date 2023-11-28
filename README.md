# my-docker-elixir

A list of Elixir images maintained by me that are automatically built and pushed to [Docker Hub](https://hub.docker.com/repository/docker/hentioe/elixir).

## Introduction

This series of images is a new choice in addition to the official images. All of Hentioe's own projects are based on this series of images.

## Version

This repository typically maintains only the latest two minor versions, such as the current `1.16` and `1.15`. It is built on top of the base images needed by Hentioe, mainly Debian (`-slim`), Alpine (`-alpine`) and Void Linux (`-void`).

>Due to Docker Hub's limitations on the use of automatic build features, the images in this repository are built and pushed from a CI server.

## Usage

Pull the latest image:

```bash
docker pull hentioe/elixir:1.16-otp-26-slim
```

You can also pull without specifying any tags, which will default to fetching the latest version, including release candidate (RC) versions. Additionally, you can use image tags with specific revision numbers, such as `1.16.0-rc.0-otp-26-slim`.

## Supported tags and respective `Dockerfile` links

- [`1.16.0-rc.0-otp-26-slim`, `1.16-otp-26-slim`, `latest`](https://github.com/Hentioe/my-docker-elixir/blob/main/1.16/otp-26-slim/Dockerfile)
- [`1.16.0-rc.0-otp-26-alpine`, `1.16-otp-26-alpine`](https://github.com/Hentioe/my-docker-elixir/blob/main/1.16/otp-26-alpine/Dockerfile)
- [`1.16.0-rc.0-otp-26-void`, `1.16-otp-26-void`](https://github.com/Hentioe/my-docker-elixir/blob/main/1.16/otp-26-void/Dockerfile)
- [`1.15.7-otp-26-slim`, `1.15-otp-26-slim`](https://github.com/Hentioe/my-docker-elixir/blob/main/1.15/otp-26-slim/Dockerfile)
- [`1.15.7-otp-26-alpine`, `1.15-otp-26-alpine`](https://github.com/Hentioe/my-docker-elixir/blob/main/1.15/otp-26-alpine/Dockerfile)
- [`1.14.5-otp-26-slim`, `1.14-otp-26-slim`](https://github.com/Hentioe/my-docker-elixir/blob/main/1.14/otp-26-slim/Dockerfile)
- [`1.14.5-otp-26-alpine`, `1.14-otp-26-alpine`](https://github.com/Hentioe/my-docker-elixir/blob/main/1.14/otp-26-alpine/Dockerfile)

## Local build

To pull this project to your local machine and execute the `build.exs` script to quickly build and test the required image.

Command Syntax: `elixir build.exs [version] [base]`, where `[version]` represents the complete Elixir version, and `[base]` represents the base image.

_The `[version]` parameter must include the `patch` version number._

Example: Build an image with Elixir version `1.16.0-rc.0` based on `otp-26-slim`:

```bash
elixir build.exs 1.16.0-rc.0 otp-26-slim
```

If the last line of the output shows `ok` it indicates a successful build and test. The resulting image will be named `local/elixir:1.15-otp-26-slim`.

_Note: The label of the completed local image does not include the `patch` version number._

## Advantages

1. Typically, the versions of images in this repository are updated more quickly because the official image maintainers are slow.
2. This repository is based on Erlang images I build myself. Similarly, these Erlang image versions are updated more quickly. Importantly, the images in this repository are based on more specific Erlang versions, such as `26.1.2` rather than just `26`.

## ARM64 support

The `-arm64` suffix in the tag name is the image of the arm64 architecture. For some reasons, I had to build them independently.
