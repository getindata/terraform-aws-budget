module "aws_budgets" {
  source  = "github.com/getindata/terraform-aws-budget?ref=v1.0.0"
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
