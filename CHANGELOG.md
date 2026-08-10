# Changelog

All notable changes to this module are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [1.2.0] - 2026-08-10

### Changed

- Upgraded `azurerm` provider requirement from `~> 4.0` to `~> 5.0` (tested against `azurerm v5.0.1`).
- Bumped `.terraform.lock.hcl` to `azurerm v5.0.1`.
- Bumped `ESLZ/appServicePlan.tf` module `ref=` to `v1.2.0`.
- Bumped GitHub Actions pins: `actions/checkout` to `v7.0.1`, `hashicorp/setup-terraform` to `v4.0.1`, `terraform-linters/setup-tflint` to `v6.3.0` (tflint `v0.64.0`).

### Notes

- No breaking changes to `azurerm_service_plan` between v4.x and v5.0 — the provider's [5.0 upgrade guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/5.0-upgrade-guide) does not list this resource under Removed Resources or Breaking Changes in Resources.
- Provider-level v5.0 changes (resource provider registration defaults, enhanced validation defaults) apply to the `provider "azurerm"` block, which is configured by module callers (L1/L2), not by this module — no action required here.
- Existing `ESLZ/*.tfvars` configurations produce an identical plan after this upgrade.

## [1.1.0] - 2026-04-01

### Changed

- Upgraded `azurerm` provider requirement to `~> 4.0` (tested against `azurerm v4.66.0`).
- Added `premium_plan_auto_scale_enabled` argument (azurerm >= 4.x).
- Added missing infrastructure files: `providers.tf`, `.gitignore`, `.gitattributes`, `.tflint.hcl`, CI workflow, `tests/`.

## [1.0.4] and earlier

- See git history for changes prior to CHANGELOG.md being introduced.
