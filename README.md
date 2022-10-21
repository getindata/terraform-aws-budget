# Terraform AWS Budget

![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)

<!--- Replace repository name -->
![License](https://badgen.net/github/license/getindata/terraform-aws-budget/)
![Release](https://badgen.net/github/release/getindata/terraform-aws-budget/)

<p align="center">
  <img height="150" src="https://getindata.com/img/logo.svg">
  <h3 align="center">We help companies turn their data into assets</h3>
</p>

---

This terraform module creates and manages multiple AWS budgets for single AWS Account.

It makes use of submodules, placed in `./modules` directory, to create the resources.

## USAGE

```terraform
module "aws_budgets" {
  source  = "github.com/getindata/terraform-aws-budget"
  context = module.this.context

  budgets = {
    default = {
      limit_amount = 100
    }
  }

  default_notifications = {
    default-actual-100 = {
      comparison_operator = "GREATER_THAN"
      threshold = 100
      threshold_type = "PERCENTAGE"
      notification_type = "ACTUAL"
      subscriber_email_addresses = []
    }
  }

  default_email_addresses = ["aws@example.com"]
```

## NOTES

This module uses a specific `budgets` object for configurations - below paragraph describes it in detail:

```terraform
    ```
    {
      BUDGET-NAME = {
        # Optional
        budget_type # - Whether this budget tracks monetary cost or usage. Availiable options: 'COST', 'USAGE', 'SAVINGS_PLANS_UTILIZATION', 'RI_UTILIZATION'."
        time_period_start # - The start of the time period covered by the budget. If you don't specify a start date, AWS defaults to the start of your chosen time period. The start date must come before the end date. Format: 2017-01-01_12:00
        time_period_end # - The end of the time period covered by the budget. There are no restrictions on the end date. Format: 2017-01-01_12:00
        name # - Budget name (if omitted, map key, BUDGET-NAME will be used)
        time_unit # -The length of time until a budget resets the actual and forecasted spend. Valid values: MONTHLY, QUARTERLY, ANNUALLY, and DAILY
        extra_email_addresses # - List containing email addresses that will receive all notifications
        cost filters # - A list of CostFilter name/values pair to apply to budget
        [
          {
            name  string # - A list of CostFilter name/values pair to apply to budget
            value = list(string) # - Refer to AWS CostFilter documentation for further detail.
          }
        ]
        notifications # - A map of objects containing Budget Notifications 
        {
          NOTIFICATION-NAME = {
            comparison_operator # - Comparison operator to use to evaluate the condition. Can be LESS_THAN, EQUAL_TO or GREATER_THAN.
            threshold # - Threshold when the notification should be sent.
            threshold_type # - What kind of threshold is defined. Can be PERCENTAGE OR ABSOLUTE_VALUE.
            notification_type # - What kind of budget value to notify on. Can be ACTUAL or FORECASTED.
            subscriber_email_addresses # - E-Mail addresses to notify.
          },
        }
        extra_notifications # - A map of objects containing Additional Budget Notifications (will be combined with var.default_notifications)
        {
          ADDITIONAL-NOTIFICATION-NAME = {
            comparison_operator # - Comparison operator to use to evaluate the condition. Can be LESS_THAN, EQUAL_TO or GREATER_THAN.
            threshold # - Threshold when the notification should be sent.
            threshold_type # - What kind of threshold is defined. Can be PERCENTAGE OR ABSOLUTE_VALUE.
            notification_type # - What kind of budget value to notify on. Can be ACTUAL or FORECASTED.
            subscriber_email_addresses # - E-Mail addresses to notify.
          },
        }
        cost_types # - A map containing CostTypes The types of cost included in a budget, such as tax and subscriptions.
        {
          include_credit # - A boolean value whether to include credits in the cost budget. Defaults to true
          include_discount # - Specifies whether a budget includes discounts. Defaults to true
          include_other_subscription # - A boolean value whether to include other subscription costs in the cost budget. Defaults to true
          include_recurring # - A boolean value whether to include recurring costs in the cost budget. Defaults to true
          include_refund # - A boolean value whether to include refunds in the cost budget. Defaults to true
          include_subscription # - A boolean value whether to include subscriptions in the cost budget. Defaults to true
          include_support # - A boolean value whether to include support costs in the cost budget. Defaults to true
          include_tax # - A boolean value whether to include tax in the cost budget. Defaults to true
          include_upfront # - A boolean value whether to include upfront costs in the cost budget. Defaults to true
          use_amortized # - Specifies whether a budget uses the amortized rate. Defaults to false
          use_blended # - A boolean value whether to use blended costs in the cost budget. Defaults to false
        }

        # Required
        limit_amount # - The amount of cost or usage being measured for a budget
      }
    }
    ```
```

<!-- BEGIN_TF_DOCS -->
## EXAMPLES
```hcl
module "aws_budgets" {
  source  = "../../"
  context = module.this.context

  budgets = {
    custom-notifications = {
      budget_type       = "COST"
      limit_amount      = 1000
      time_period_start = "2017-01-01_12:00"
      time_period_end   = "2017-02-01_12:00"
      time_unit         = "MONTHLY"

      cost_filters = [
        {
          name  = "AZ"
          value = ["eu-central-1b"]
        },
      ]

      cost_types = {
        include_tax = false
      }

      notifications = {
        test = {
          comparison_operator        = "GREATER_THAN"
          notification_type          = "ACTUAL"
          subscriber_email_addresses = ["test@example.com"]
          threshold                  = 80
          threshold_type             = "PERCENTAGE"
        },
      }
    },

    extra-notifications = {
      budget_type  = "COST"
      limit_amount = 100
      time_unit    = "DAILY"

      extra_notifications = {
        extra = {
          comparison_operator        = "GREATER_THAN"
          notification_type          = "ACTUAL"
          subscriber_email_addresses = ["test@example.com"]
          threshold                  = 50
          threshold_type             = "PERCENTAGE"
        },
      }
    },

    default-notifications = {
      budget_type           = "COST"
      limit_amount          = 1000
      time_period_start     = "2017-01-01_12:00"
      time_period_end       = "2017-02-01_12:00"
      time_unit             = "MONTHLY"
      extra_email_addresses = ["product_owner@example.com"]

      cost_filters = [
        {
          name  = "AZ"
          value = ["eu-central-1b"]
        },
      ]
    },

    minimal-example = {
      limit_amount = 1000
    }
  }

  default_notifications = {
    default-forcast-100 = {
      comparison_operator : "GREATER_THAN"
      threshold : 100
      threshold_type : "PERCENTAGE"
      notification_type : "FORECASTED"
      subscriber_email_addresses : []
    },
    default-actual-80 = {
      comparison_operator : "GREATER_THAN"
      threshold : 80
      threshold_type : "PERCENTAGE"
      notification_type : "ACTUAL"
      subscriber_email_addresses : []
    },
    default-actual-100 = {
      comparison_operator : "GREATER_THAN"
      threshold : 100
      threshold_type : "PERCENTAGE"
      notification_type : "ACTUAL"
      subscriber_email_addresses : []
    }
  }

  default_email_addresses = ["aws@example.com"]
}
```





## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_budgets"></a> [budgets](#input\_budgets) | A map of 'aws-budget' configuration objects:<pre>{<br>      BUDGET-NAME = {<br>        # Optional<br>        budget_type # - Whether this budget tracks monetary cost or usage. Availiable options: 'COST', 'USAGE', 'SAVINGS_PLANS_UTILIZATION', 'RI_UTILIZATION'."<br>        time_period_start # - The start of the time period covered by the budget. If you don't specify a start date, AWS defaults to the start of your chosen time period. The start date must come before the end date. Format: 2017-01-01_12:00<br>        time_period_end # - The end of the time period covered by the budget. There are no restrictions on the end date. Format: 2017-01-01_12:00<br>        name # - Budget name (if omitted, map key, BUDGET-NAME will be used)<br>        time_unit # -The length of time until a budget resets the actual and forecasted spend. Valid values: MONTHLY, QUARTERLY, ANNUALLY, and DAILY<br>        extra_email_addresses # - List containing email addresses that will receive all notifications<br>        cost filters # - A list of CostFilter name/values pair to apply to budget<br>        [<br>          {<br>            name  string # - A list of CostFilter name/values pair to apply to budget<br>            value = list(string) # - Refer to AWS CostFilter documentation for further detail.<br>          }<br>        ]<br>        notifications # - A map of objects containing Budget Notifications <br>        {<br>          NOTIFICATION-NAME = {<br>            comparison_operator # - Comparison operator to use to evaluate the condition. Can be LESS_THAN, EQUAL_TO or GREATER_THAN.<br>            threshold # - Threshold when the notification should be sent.<br>            threshold_type # - What kind of threshold is defined. Can be PERCENTAGE OR ABSOLUTE_VALUE.<br>            notification_type # - What kind of budget value to notify on. Can be ACTUAL or FORECASTED.<br>            subscriber_email_addresses # - E-Mail addresses to notify.<br>          },<br>        }<br>        extra_notifications # - A map of objects containing Additional Budget Notifications (will be combined with var.default_notifications)<br>        {<br>          ADDITIONAL-NOTIFICATION-NAME = {<br>            comparison_operator # - Comparison operator to use to evaluate the condition. Can be LESS_THAN, EQUAL_TO or GREATER_THAN.<br>            threshold # - Threshold when the notification should be sent.<br>            threshold_type # - What kind of threshold is defined. Can be PERCENTAGE OR ABSOLUTE_VALUE.<br>            notification_type # - What kind of budget value to notify on. Can be ACTUAL or FORECASTED.<br>            subscriber_email_addresses # - E-Mail addresses to notify.<br>          },<br>        }<br>        cost_types # - A map containing CostTypes The types of cost included in a budget, such as tax and subscriptions.<br>        {<br>          include_credit # - A boolean value whether to include credits in the cost budget. Defaults to true<br>          include_discount # - Specifies whether a budget includes discounts. Defaults to true<br>          include_other_subscription # - A boolean value whether to include other subscription costs in the cost budget. Defaults to true<br>          include_recurring # - A boolean value whether to include recurring costs in the cost budget. Defaults to true<br>          include_refund # - A boolean value whether to include refunds in the cost budget. Defaults to true<br>          include_subscription # - A boolean value whether to include subscriptions in the cost budget. Defaults to true<br>          include_support # - A boolean value whether to include support costs in the cost budget. Defaults to true<br>          include_tax # - A boolean value whether to include tax in the cost budget. Defaults to true<br>          include_upfront # - A boolean value whether to include upfront costs in the cost budget. Defaults to true<br>          use_amortized # - Specifies whether a budget uses the amortized rate. Defaults to false<br>          use_blended # - A boolean value whether to use blended costs in the cost budget. Defaults to false<br>        }<br><br>        # Required<br>        limit_amount # - The amount of cost or usage being measured for a budget<br>      }<br>    }</pre>Example with fully configurable notifications (not using var.default\_notifications):<pre>terraform<br>    {<br>      test-budget = {<br>        budget_type           = "COST"<br>        limit_amount          = 1000<br>        time_period_start     = "2017-01-01_12:00"<br>        time_period_end       = "2017-02-01_12:00"<br>        time_unit             = "MONTHLY"<br>        extra_email_addresses = ["product_owner@example.com"]<br><br>        cost_filters = [<br>          {<br>            name = "AZ"<br>            value = "eu-central-1b"<br>          },<br>        ]<br><br>        notifications = {<br>          test = {<br>            comparison_operator        = "GREATER_THAN"<br>            notification_type          = "ACTUAL"<br>            subscriber_email_addresses = ["test@example.com"]<br>            threshold                  = 80<br>            threshold_type             = "PERCENTAGE"<br>          },<br>        }<br>      },<br>    }</pre>Example additional notifications:<pre>terraform<br>    {<br>      test-budget = {<br>        budget_type           = "COST"<br>        limit_amount          = 1000<br>        time_period_start     = "2017-01-01_12:00"<br>        time_period_end       = "2017-02-01_12:00"<br>        time_unit             = "MONTHLY"<br>        extra_email_addresses = ["product_owner@example.com"]<br><br>        cost_filters = [<br>          {<br>            name = "AZ"<br>            value = "eu-central-1b"<br>          },<br>        ]<br><br>        extra_notifications = {<br>          extra = {<br>            comparison_operator        = "GREATER_THAN"<br>            notification_type          = "ACTUAL"<br>            subscriber_email_addresses = ["test-extra@example.com"]<br>            threshold                  = 80<br>            threshold_type             = "PERCENTAGE"<br>          },<br>        }<br>      },<br>    }</pre>Example with only default notifications:<pre>terraform<br>    {<br>      test-budget = {<br>        budget_type           = "COST"<br>        limit_amount          = 1000<br>        time_period_start     = "2017-01-01_12:00"<br>        time_period_end       = "2017-02-01_12:00"<br>        time_unit             = "MONTHLY"<br>        extra_email_addresses = ["product_owner@example.com"]<br><br>        cost_filters = [<br>          {<br>            name = "AZ"<br>            value = "eu-central-1b"<br>          },<br>        ]<br>      },<br>    }</pre> | `any` | n/a | yes |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_default_email_addresses"></a> [default\_email\_addresses](#input\_default\_email\_addresses) | A list of default e-mail addresses that will receive all notifications | `list(string)` | `[]` | no |
| <a name="input_default_notifications"></a> [default\_notifications](#input\_default\_notifications) | Configuration of default notifications<br>    map(object({<br>      comparison\_operator        = string<br>      threshold                  = number<br>      threshold\_type             = string<br>      notification\_type          = string<br>      subscriber\_email\_addresses = list(string)<br>    })) | <pre>map(object({<br>    comparison_operator        = string<br>    threshold                  = number<br>    threshold_type             = string<br>    notification_type          = string<br>    subscriber_email_addresses = list(string)<br>  }))</pre> | `{}` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_budget"></a> [aws\_budget](#module\_aws\_budget) | ./modules/budget | n/a |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_budgets"></a> [budgets](#output\_budgets) | Map of budgets configuration |

## Providers

No providers.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |

## Resources

No resources.
<!-- END_TF_DOCS -->

## CONTRIBUTING

Contributions are very welcomed!

Start by reviewing [contribution guide](CONTRIBUTING.md) and our [code of conduct](CODE_OF_CONDUCT.md). After that, start coding and ship your changes by creating a new PR.

## LICENSE

Apache 2 Licensed. See [LICENSE](LICENSE) for full details.

## AUTHORS

<!--- Replace repository name -->
<a href="https://github.com/getindata/terraform-aws-budget/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=getindata/terraform-aws-budget" />
</a>

Made with [contrib.rocks](https://contrib.rocks).
