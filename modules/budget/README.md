<!-- BEGIN_TF_DOCS -->
# AWS Budget terraform submodule

This module creates and configures single resource of AWS Budget



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_budget_type"></a> [budget\_type](#input\_budget\_type) | Whether this budget tracks monetary cost or usage. Availiable options: 'COST', 'USAGE', 'SAVINGS\_PLANS\_UTILIZATION', 'RI\_UTILIZATION'. | `string` | `"COST"` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_cost_filters"></a> [cost\_filters](#input\_cost\_filters) | A list of CostFilter name/values pair to apply to budget.<br>  Example:<pre>terraform<br>  [<br>    {<br>      name  = "AZ"<br>      value = ["eu-central-1b"]<br>    },<br>  ]</pre> | <pre>list(object({<br>    name  = string<br>    value = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_cost_types"></a> [cost\_types](#input\_cost\_types) | Map containing CostTypes The types of cost included in a budget, such as tax and subscriptions.<br>    Valid keys:<br>      include\_credit - A boolean value whether to include credits in the cost budget. Defaults to true<br>      include\_discount - Specifies whether a budget includes discounts. Defaults to true<br>      include\_other\_subscription - A boolean value whether to include other subscription costs in the cost budget. Defaults to true<br>      include\_recurring - A boolean value whether to include recurring costs in the cost budget. Defaults to true<br>      include\_refund - A boolean value whether to include refunds in the cost budget. Defaults to true<br>      include\_subscription - A boolean value whether to include subscriptions in the cost budget. Defaults to true<br>      include\_support - A boolean value whether to include support costs in the cost budget. Defaults to true<br>      include\_tax - A boolean value whether to include tax in the cost budget. Defaults to true<br>      include\_upfront - A boolean value whether to include upfront costs in the cost budget. Defaults to true<br>      use\_amortized - Specifies whether a budget uses the amortized rate. Defaults to false<br>      use\_blended - A boolean value whether to use blended costs in the cost budget. Defaults to false | `map(string)` | `{}` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_extra_email_addresses"></a> [extra\_email\_addresses](#input\_extra\_email\_addresses) | A list of additional e-mail addresses that will receive all notifications | `list(string)` | `[]` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_limit_amount"></a> [limit\_amount](#input\_limit\_amount) | The amount of cost or usage being measured for a budget | `number` | n/a | yes |
| <a name="input_limit_unit"></a> [limit\_unit](#input\_limit\_unit) | The unit of measurement used for the budget forecast, actual spend, or budget threshold. | `string` | `"USD"` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_notifications"></a> [notifications](#input\_notifications) | A map of objects containing Budget Notifications. Required object fields:<br>    comparison\_operator - Comparison operator to use to evaluate the condition. Can be LESS\_THAN, EQUAL\_TO or GREATER\_THAN.<br>    threshold - Threshold when the notification should be sent.<br>    threshold\_type - What kind of threshold is defined. Can be PERCENTAGE OR ABSOLUTE\_VALUE.<br>    notification\_type - What kind of budget value to notify on. Can be ACTUAL or FORECASTED.<br>    subscriber\_email\_addresses - E-Mail addresses to notify.<br>  Example:<pre>terraform <br>    test = {<br>      comparison_operator        = "GREATER_THAN"<br>      notification_type          = "ACTUAL"<br>      subscriber_email_addresses = ["notifications@example.com"]<br>      threshold                  = 80<br>      threshold_type             = "PERCENTAGE"<br>    }</pre> | <pre>map(object(<br>    {<br>      comparison_operator        = string<br>      threshold                  = number<br>      threshold_type             = string<br>      notification_type          = string<br>      subscriber_email_addresses = list(string)<br>    }<br>  ))</pre> | n/a | yes |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |
| <a name="input_time_period_end"></a> [time\_period\_end](#input\_time\_period\_end) | The end of the time period covered by the budget. There are no restrictions on the end date. Format: 2017-01-01\_12:00 | `string` | `null` | no |
| <a name="input_time_period_start"></a> [time\_period\_start](#input\_time\_period\_start) | The start of the time period covered by the budget. If you don't specify a start date, AWS defaults to the start of your chosen time period. The start date must come before the end date. Format: 2017-01-01\_12:00 | `string` | `null` | no |
| <a name="input_time_unit"></a> [time\_unit](#input\_time\_unit) | The length of time until a budget resets the actual and forecasted spend. Valid values: MONTHLY, QUARTERLY, ANNUALLY, and DAILY. | `string` | `"MONTHLY"` | no |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the budget |
| <a name="output_budget_type"></a> [budget\_type](#output\_budget\_type) | Type of the budget |
| <a name="output_cost_filter"></a> [cost\_filter](#output\_cost\_filter) | A list of CostFilter name/values pair to apply to budget. |
| <a name="output_id"></a> [id](#output\_id) | ID of the budget |
| <a name="output_limit_amount"></a> [limit\_amount](#output\_limit\_amount) | The amount of cost or usage being measured for a budget. |
| <a name="output_name"></a> [name](#output\_name) | The name of a budget. Unique within accounts. |
| <a name="output_notification"></a> [notification](#output\_notification) | Object containing Budget Notifications. |
| <a name="output_time_period_end"></a> [time\_period\_end](#output\_time\_period\_end) | The end of the time period covered by the budget |
| <a name="output_time_period_start"></a> [time\_period\_start](#output\_time\_period\_start) | The start of the time period covered by the budget |
| <a name="output_time_unit"></a> [time\_unit](#output\_time\_unit) | The length of time until a budget resets the actual and forecasted spend. |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Resources

| Name | Type |
|------|------|
| [aws_budgets_budget.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/budgets_budget) | resource |
<!-- END_TF_DOCS -->
