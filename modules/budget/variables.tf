# Example, compulsory input variable
variable "budget_type" {
  description = "Whether this budget tracks monetary cost or usage. Availiable options: 'COST', 'USAGE', 'SAVINGS_PLANS_UTILIZATION', 'RI_UTILIZATION'."
  type        = string
  default     = "COST"
}

variable "limit_amount" {
  description = "The amount of cost or usage being measured for a budget"
  type        = number
}

variable "limit_unit" {
  description = "The unit of measurement used for the budget forecast, actual spend, or budget threshold."
  type        = string
  default     = "USD"
}

variable "time_period_start" {
  description = "The start of the time period covered by the budget. If you don't specify a start date, AWS defaults to the start of your chosen time period. The start date must come before the end date. Format: 2017-01-01_12:00"
  type        = string
  default     = null
}

variable "time_period_end" {
  description = "The end of the time period covered by the budget. There are no restrictions on the end date. Format: 2017-01-01_12:00"
  type        = string
  default     = null
}

variable "time_unit" {
  description = "The length of time until a budget resets the actual and forecasted spend. Valid values: MONTHLY, QUARTERLY, ANNUALLY, and DAILY."
  type        = string
  default     = "MONTHLY"
}

variable "cost_filters" {
  description = <<EOT
  A list of CostFilter name/values pair to apply to budget.
  Example:
  ```terraform
  [
    {
      name  = "AZ"
      value = ["eu-central-1b"]
    },
  ]
  EOT
  type = list(object({
    name  = string
    value = list(string)
  }))
  default = []
}

variable "notifications" {
  description = <<EOT
  A map of objects containing Budget Notifications. Required object fields:
    comparison_operator - Comparison operator to use to evaluate the condition. Can be LESS_THAN, EQUAL_TO or GREATER_THAN.
    threshold - Threshold when the notification should be sent.
    threshold_type - What kind of threshold is defined. Can be PERCENTAGE OR ABSOLUTE_VALUE.
    notification_type - What kind of budget value to notify on. Can be ACTUAL or FORECASTED.
    subscriber_email_addresses - E-Mail addresses to notify.
  Example:
  ```terraform 
    test = {
      comparison_operator        = "GREATER_THAN"
      notification_type          = "ACTUAL"
      subscriber_email_addresses = ["notifications@example.com"]
      threshold                  = 80
      threshold_type             = "PERCENTAGE"
    }
  ```
  EOT
  type = map(object(
    {
      comparison_operator        = string
      threshold                  = number
      threshold_type             = string
      notification_type          = string
      subscriber_email_addresses = list(string)
    }
  ))
}

variable "default_email_addresses" {
  description = "A list of default e-mail addresses that will receive all notifications"
  type        = list(string)
  default     = []
}

variable "cost_types" {
  description = <<EOT
    Map containing CostTypes The types of cost included in a budget, such as tax and subscriptions.
    Valid keys:
      include_credit - A boolean value whether to include credits in the cost budget. Defaults to true
      include_discount - Specifies whether a budget includes discounts. Defaults to true
      include_other_subscription - A boolean value whether to include other subscription costs in the cost budget. Defaults to true
      include_recurring - A boolean value whether to include recurring costs in the cost budget. Defaults to true
      include_refund - A boolean value whether to include refunds in the cost budget. Defaults to true
      include_subscription - A boolean value whether to include subscriptions in the cost budget. Defaults to true
      include_support - A boolean value whether to include support costs in the cost budget. Defaults to true
      include_tax - A boolean value whether to include tax in the cost budget. Defaults to true
      include_upfront - A boolean value whether to include upfront costs in the cost budget. Defaults to true
      use_amortized - Specifies whether a budget uses the amortized rate. Defaults to false
      use_blended - A boolean value whether to use blended costs in the cost budget. Defaults to false
  EOT
  type        = map(string)
  default     = {}
}
