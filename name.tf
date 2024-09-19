locals {
  anti-pattern-regex = "/[//\"'\\[\\]:|<>+=;,?*@&]/"
  asp-name = replace("${var.env}-${var.group}-${var.project}-${var.userDefinedString}-asp", local.anti-pattern-regex, "")
}