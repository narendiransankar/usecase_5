# Conftest

[![Go Report Card](https://goreportcard.com/badge/open-policy-agent/opa)](https://goreportcard.com/report/open-policy-agent/conftest) [![Netlify](https://api.netlify.com/api/v1/badges/2d928746-3380-4123-b0eb-1fd74ba390db/deploy-status)](https://app.netlify.com/sites/vibrant-villani-65041c/deploys)

Conftest helps you write tests against structured configuration data. Using Conftest you can
write tests for your Kubernetes configuration, Tekton pipeline definitions, Terraform code,
Serverless configs or any other config files.

Conftest uses the Rego language from [Open Policy Agent](https://www.openpolicyagent.org/) for writing
the assertions. You can read more about Rego in [How do I write policies](https://www.openpolicyagent.org/docs/how-do-i-write-policies.html)
in the Open Policy Agent documentation.

Here's a quick example. Save the following as `policy/deployment.rego`:

```rego
package main

deny[msg] {
  input.kind == "Deployment"
  not input.spec.template.spec.securityContext.runAsNonRoot

  msg := "Containers must not run as root"
}

deny[msg] {
  input.kind == "Deployment"
  not input.spec.selector.matchLabels.app

  msg := "Containers must provide app label for pod selectors"
}
```

Assuming you have a Kubernetes deployment in `deployment.yaml` you can run Conftest like so:

```console
$ conftest test deployment.yaml
FAIL - deployment.yaml - Containers must not run as root
FAIL - deployment.yaml - Containers must provide app label for pod selectors

2 tests, 0 passed, 0 warnings, 2 failures, 0 exceptions
```

Conftest isn't specific to Kubernetes. It will happily let you write tests for any configuration files in a variety of different formats. See the [documentation](https://www.conftest.dev/) for [installation instructions](https://www.conftest.dev/install/) and
more details about the features.

## Want to contribute to Conftest?

* See [DEVELOPMENT.md](DEVELOPMENT.md) to build and test Conftest itself.
* See [CONTRIBUTING.md](CONTRIBUTING.md) to get started.

For discussions and questions join us on the [Open Policy Agent Slack](https://slack.openpolicyagent.org/)
in the `#opa-conftest` channel.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | ~> 2.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda"></a> [lambda](#module\_lambda) | ./modules/lambda | n/a |
| <a name="module_s3"></a> [s3](#module\_s3) | ./modules/s3 | n/a |
| <a name="module_sns"></a> [sns](#module\_sns) | ./modules/sns | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_destination_bucket_name"></a> [destination\_bucket\_name](#input\_destination\_bucket\_name) | n/a | `string` | n/a | yes |
| <a name="input_lambda_function_name"></a> [lambda\_function\_name](#input\_lambda\_function\_name) | n/a | `string` | n/a | yes |
| <a name="input_notification_email"></a> [notification\_email](#input\_notification\_email) | n/a | `string` | n/a | yes |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | n/a | `string` | n/a | yes |
| <a name="input_sns_topic_name"></a> [sns\_topic\_name](#input\_sns\_topic\_name) | n/a | `string` | n/a | yes |
| <a name="input_source_bucket_name"></a> [source\_bucket\_name](#input\_source\_bucket\_name) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->