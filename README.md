# my-docker-elixir

My Elixir images, they are usually always up to date.

## Introduction

Since DockerHub limits the automatic build feature for personal accounts, the images are built and published on my own server, which are also automated.

## Usage

Pull the latest image:

```bash
docker pull hentioe/elixir:1.15-otp-26-slim
```

Or without any tags, which defaults to the latest version (including RC versions).

In addition, you can also use image tags with minor version numbers, such as `1.15.0-rc.1-otp-26-slim`.

## Advantages

Unlike official images, the images I maintain are based on more specific Erlang versions, such as `26.0-slim` instead of `26-slim`. So when Erlang releases a new minor version number, I will update all images. In short, the Erlang version in the images I maintain is always the latest.

## More

- 加入我的 Elixir 交流群：[@elixircn_community](https://t.me/elixircn_community)
