# Example, compulsory input variable
variable "budgets" {
  description = <<EOT
    A map of 'aws-budget' configuration objects:
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
    Example with fully configurable notifications (not using var.default_notifications):
    ```terraform
    {
      test-budget = {
        budget_type           = "COST"
        limit_amount          = 1000
        time_period_start     = "2017-01-01_12:00"
        time_period_end       = "2017-02-01_12:00"
        time_unit             = "MONTHLY"
        extra_email_addresses = ["product_owner@example.com"]

        cost_filters = [
          {
            name = "AZ"
            value = "eu-central-1b"
          },
        ]

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
    }
    ```
    Example additional notifications:
    ```terraform
    {
      test-budget = {
        budget_type           = "COST"
        limit_amount          = 1000
        time_period_start     = "2017-01-01_12:00"
        time_period_end       = "2017-02-01_12:00"
        time_unit             = "MONTHLY"
        extra_email_addresses = ["product_owner@example.com"]

        cost_filters = [
          {
            name = "AZ"
            value = "eu-central-1b"
          },
        ]

        extra_notifications = {
          extra = {
            comparison_operator        = "GREATER_THAN"
            notification_type          = "ACTUAL"
            subscriber_email_addresses = ["test-extra@example.com"]
            threshold                  = 80
            threshold_type             = "PERCENTAGE"
          },
        }
      },
    }
    ```
    Example with only default notifications:
    ```terraform
    {
      test-budget = {
        budget_type           = "COST"
        limit_amount          = 1000
        time_period_start     = "2017-01-01_12:00"
        time_period_end       = "2017-02-01_12:00"
        time_unit             = "MONTHLY"
        extra_email_addresses = ["product_owner@example.com"]

        cost_filters = [
          {
            name = "AZ"
            value = "eu-central-1b"
          },
        ]
      },
    }
    ```
  EOT
  type        = any
}

variable "default_notifications" {
  description = <<EOT
    Configuration of default notifications
    map(object({
      comparison_operator        = string
      threshold                  = number
      threshold_type             = string
      notification_type          = string
      subscriber_email_addresses = list(string)
    }))
  EOT
  type = map(object({
    comparison_operator        = string
    threshold                  = number
    threshold_type             = string
    notification_type          = string
    subscriber_email_addresses = list(string)
  }))
  default = {}
}

variable "default_email_addresses" {
  description = "A list of default e-mail addresses that will receive all notifications"
  type        = list(string)
  default     = []
}
