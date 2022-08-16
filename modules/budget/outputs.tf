# Example output from the module
output "id" {
  description = "ID of the budget"
  value       = resource.aws_budgets_budget.this.id
}

output "arn" {
  description = "ARN of the budget"
  value       = resource.aws_budgets_budget.this.arn
}

output "budget_type" {
  description = "Type of the budget"
  value       = resource.aws_budgets_budget.this.budget_type
}

output "cost_filter" {
  description = "A list of CostFilter name/values pair to apply to budget."
  value       = resource.aws_budgets_budget.this.cost_filter
}

output "limit_amount" {
  description = "The amount of cost or usage being measured for a budget."
  value       = resource.aws_budgets_budget.this.limit_amount
}

output "time_period_start" {
  description = " The start of the time period covered by the budget"
  value       = resource.aws_budgets_budget.this.time_period_start
}

output "time_period_end" {
  description = "The end of the time period covered by the budget"
  value       = resource.aws_budgets_budget.this.time_period_end
}

output "name" {
  description = "The name of a budget. Unique within accounts."
  value       = resource.aws_budgets_budget.this.name
}

output "time_unit" {
  description = "The length of time until a budget resets the actual and forecasted spend."
  value       = resource.aws_budgets_budget.this.time_unit
}

output "notification" {
  description = "Object containing Budget Notifications."
  value       = resource.aws_budgets_budget.this.notification
}
