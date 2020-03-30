# kubeact
![Kubeact](https://github.com/itsksaurabh/kubeact/workflows/Kubeact/badge.svg)

A Helm chart for hosting your own runner on Kubernetes to run jobs in your GitHub Actions workflows. ☸️ 🚀

## What is Kubeact? ☸️ 🚀

**Kubeact** is a [Helm](https://helm.sh/) Chart/Package for [Kubernetes (K8s)](https://kubernetes.io/) to deploy and host your own runners on the cluster to run jobs in your [GitHub Actions](https://github.com/features/actions) workflows. It makes it easy to automate all your software workflows, now with world-class CI/CD. Build, test, and deploy your code right from GitHub. 

##  Why Kubeact? 🧐

Kubeact sets up a self-hosted runner on the cluster. Self-hosted runners offer more control of hardware, operating system, and software tools than GitHub-hosted runners provide. With self-hosted runners, you can choose to create a custom hardware configuration with more processing power or memory to run larger jobs, install software available on your local network, and choose an operating system not offered by GitHub-hosted runners.
You can read more about self-hosted runner [here](https://help.github.com/en/actions/hosting-your-own-runners/about-self-hosted-runners).

> **Note**: Currently kubeact supports machines with Linux X64 architecture.

## Prerequisites ✅

**Helm**

Ensure you have [Helm](https://helm.sh/) installed. It is a package manager for Kubernetes which will be required to install the chart.

**Docker**

This repository contains a [Dockerfile](Dockerfile) by which you can build your own personal runner image, which will be pulled while installing the helm chart. You can follow the official Docker installation guide [here](https://docs.docker.com/install/).

**Github personal access token**

The [Dockerfile](Dockerfile) requires Github personal access token during build for the admin access to the repository and to configure the runner. You can create a personal access token by following this [tutorial](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line).

 ## Usage ⚙️

**Build your runner image**

Login into your docker account, Run:
```sh
$ docker login --username=yourUserName --email=yourUserName@example.com
```
Run the following command to build your own runner image:

```sh
$ docker build \
  -t yourUserName/kubeact:tagname \
  --build-arg GITHUB_ACCESS_TOKEN=XXXXXXXXXXXXXX \
  --build-arg GITHUB_USERNAME=< Your Github Username > \
  --build-arg GITHUB_REPO_NAME=< Your target Github repo name >  .
```

Push the image into your registry:

```sh
$ docker push yourUserName/kubeact:tagname
```

> **Warning**: It is adviced to push the image into a private registry as it contains files that contains your sensitive informations.

**Install the Helm chart**

Open [values.yaml](values.yaml) and update the following values :

***Chart Values***

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.name | string | `"kubeact"` | Name of your image. |
| image.username | string | `nil` | Your Docker registry username. |
| image.password | string | `nil` | Your Docker registry password. |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy. |
| image.registry | string | `"https://index.docker.io/v1/"` | Your registry server. |
| image.tag | string | `"latest"` | Your Image tag. |

Run the following command to install the chart to your kubernetes cluster:

```sh
$ helm install kubeact .
```
> **Note**: You can also update the values using --set flag.

# Contributing 🍻

I welcome pull requests, bug fixes and issue reports. Before proposing a change, please discuss your change by raising an issue.

# Maintainer 😎

[Kumar Saurabh](https://in.linkedin.com/in/itsksaurabh)

## License

[MIT](LICENSE) © Kumar Saurabh

