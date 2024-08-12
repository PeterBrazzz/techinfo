locals {
  strg_prefix = replace(var.prefix, "-", "0")
  strg_team = replace(var.team, "-", "0")
}
