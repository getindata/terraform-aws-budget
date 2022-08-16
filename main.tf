module "aws_budget" {
  for_each = var.budgets

  source  = "./modules/budget"
  context = module.this.context

  # Compulsory values
  ## Use map key as name if name is missing
  name         = lookup(each.value, "name", each.key)
  limit_amount = each.value.limit_amount
  ## If no notifications specified, use default notifications (when notifications are specified, no defaults are used),
  ## to add additional notifications to default ones - `extra_notifications` should be set
  notifications = can(each.value.notifications) ? each.value.notifications : merge(var.default_notifications, lookup(each.value, "extra_notifications", {}))

  # Optional values
  time_unit               = lookup(each.value, "time_unit", "MONTHLY")
  budget_type             = lookup(each.value, "budget_type", "COST")
  time_period_start       = lookup(each.value, "time_period_start", null)
  time_period_end         = lookup(each.value, "time_period_end", null)
  cost_filters            = lookup(each.value, "cost_filters", [])
  cost_types              = lookup(each.value, "cost_types", {})
  default_email_addresses = var.default_email_addresses
}
