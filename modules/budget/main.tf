/**
 * # AWS Budget terraform submodule
 *
 * This module creates and configures single resource of AWS Budget
 */

resource "aws_budgets_budget" "this" {
  name              = replace(lookup(module.this.descriptors, "budget", module.this.id), "/--+/", "-")
  budget_type       = var.budget_type
  limit_amount      = var.limit_amount
  limit_unit        = var.limit_unit
  time_period_start = var.time_period_start
  time_period_end   = var.time_period_end
  time_unit         = var.time_unit

  dynamic "cost_filter" {
    for_each = var.cost_filters
    content {
      name   = cost_filter.value.name
      values = cost_filter.value.value
    }
  }

  dynamic "notification" {
    for_each = var.notifications
    content {
      comparison_operator        = notification.value.comparison_operator
      threshold                  = notification.value.threshold
      threshold_type             = notification.value.threshold_type
      notification_type          = notification.value.notification_type
      subscriber_email_addresses = distinct(concat(lookup(notification.value, "subscriber_email_addresses", []), var.extra_email_addresses))
    }
  }

  cost_types {
    include_credit             = lookup(var.cost_types, "include_credit", true)
    include_discount           = lookup(var.cost_types, "include_discount", true)
    include_other_subscription = lookup(var.cost_types, "include_other_subscription", true)
    include_recurring          = lookup(var.cost_types, "include_recurring", true)
    include_refund             = lookup(var.cost_types, "include_refund", true)
    include_support            = lookup(var.cost_types, "include_support", true)
    include_tax                = lookup(var.cost_types, "include_tax", true)
    include_upfront            = lookup(var.cost_types, "include_upfront", true)
    use_amortized              = lookup(var.cost_types, "use_amortized", false)
    use_blended                = lookup(var.cost_types, "use_blended", false)
  }
}
