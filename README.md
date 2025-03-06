# my-docker-elixir

A list of Elixir images maintained by me that are automatically built and pushed to [Docker Hub](https://hub.docker.com/repository/docker/hentioe/elixir).

## Introduction

This series of images is a new choice in addition to the official images. All of Hentioe's own projects are based on this series of images.

## Version

This repository typically maintains only the latest two minor versions, such as the current `1.18` and `1.17`. It is built on top of the base images needed by Hentioe, mainly Debian (`-slim`), Alpine (`-alpine`) and Void Linux (`-void`).

> Due to Docker Hub's limitations on the use of automatic build features, the images in this repository are built and pushed from a CI server.

## Usage

Pull the latest image:

```bash
docker pull hentioe/elixir:1.18.3-otp-27-slim
```

You can also pull without specifying any tags, which will default to fetching the latest version, including release candidate (RC) versions. Additionally, you can use image tags with specific revision numbers, such as `1.17.3-otp-27-slim`.

## Supported tags and respective `Dockerfile` links

- [`1.18.3-otp-27-slim`, `1.18-otp-26-slim`, `latest`](https://github.com/Hentioe/my-docker-elixir/blob/main/1.18/otp-27-slim/Dockerfile)
- [`1.18.3-otp-27-alpine`, `1.18-otp-26-alpine`](https://github.com/Hentioe/my-docker-elixir/blob/main/1.18/otp-27-alpine/Dockerfile)
- [`1.18.3-otp-27-void`, `1.18-otp-26-void`](https://github.com/Hentioe/my-docker-elixir/blob/main/1.18/otp-27-void/Dockerfile)
- [`1.17.3-otp-27-slim`, `1.17-otp-26-slim`, `latest`](https://github.com/Hentioe/my-docker-elixir/blob/main/1.17/otp-27-slim/Dockerfile)
- [`1.17.3-otp-27-alpine`, `1.17-otp-26-alpine`](https://github.com/Hentioe/my-docker-elixir/blob/main/1.17/otp-27-alpine/Dockerfile)
- [`1.17.3-otp-27-void`, `1.17-otp-26-void`](https://github.com/Hentioe/my-docker-elixir/blob/main/1.17/otp-27-void/Dockerfile)

## Runner Images

Package the `mix release` artifact into the runner image for deployment. The runner image corresponding to each version is:

| tag                    | runner base                                        |
| :--------------------- | :------------------------------------------------- |
| `1.18.3-otp-27-void`   | `ghcr.io/void-linux/void-glibc-busybox:20250214R1` |
| `1.18.3-otp-27-alpine` | `alpine:3.21`                                      |
| `1.18.3-otp-27-slim`   | `debian:bookworm`                                  |
| `1.17.3-otp-27-void`   | `ghcr.io/void-linux/void-glibc-busybox:20250214R1` |
| `1.17.3-otp-27-alpine` | `alpine:3.21`                                      |
| `1.17.3-otp-27-slim`   | `debian:bookworm`                                  |

## Local build

To pull this project to your local machine and execute the `build.exs` script to quickly build and test the required image.

Command Syntax: `elixir build.exs [version] [base]`, where `[version]` represents the complete Elixir version, and `[base]` represents the base image.

_The `[version]` parameter must include the `patch` version number._

Example: Build an image with Elixir version `1.18.3` based on `otp-27-slim`:

```bash
elixir build.exs 1.18.3 otp-27-slim
```

If the last line of the output shows `ok` it indicates a successful build and test. The resulting image will be named `local/elixir:1.18-otp-27-slim`.

_Note: The label of the completed local image does not include the `patch` version number._

## ARM64 support

Starting from version 1.16, this repository provides `arm64` builds.
