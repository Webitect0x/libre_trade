terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "6.2.3"
    }
  }
}



locals {
  repository_name = "libre_trade"
  github_owner = "Webitect0x"
}

provider "github" {
  owner = local.github_owner
}

resource "github_repository" "libre_trade" {
  name = local.repository_name
  description = "Libre Trade -  A community-driven P2P marketplace"
  visibility = "public"
  has_issues = true
  auto_init = true
  gitignore_template = "Terraform"
  delete_branch_on_merge = true
}

resource "github_repository_milestone" "epics" {
  for_each = var.milestones
  owner = local.github_owner
  repository = github_repository.libre_trade.name
  title = each.value.title
  description = each.value.description
  due_date = each.value.due_date
}

resource "github_issue_label" "issues_labels" {
  for_each = var.labels
  repository = github_repository.libre_trade.name
  name = each.value.name
  color = each.value.color
}

resource "github_issue" "tasks" {
  count = length(var.issues)
  repository = github_repository.libre_trade.name
  title = var.issues[count.index].title
  body = var.issues[count.index].body
  milestone_number = github_repository_milestone.epics[
    var.issues[count.index].milestone
  ].number
  labels = [for l in var.issues[count.index].labels :
    github_issue_label.issues_labels[l].name
  ]
}