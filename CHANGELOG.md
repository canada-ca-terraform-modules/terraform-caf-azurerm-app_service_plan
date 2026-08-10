# Changelog

All notable changes to this module are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [1.2.0] - 2026-08-10

### Changed

- Upgraded `azurerm` provider requirement from `~> 4.0` to `~> 5.0` (tested against `azurerm v5.0.1`).
- Bumped `.terraform.lock.hcl` to `azurerm v5.0.1`.
- Bumped `ESLZ/appServicePlan.tf` module `ref=` to `v1.2.0`.
- Bumped GitHub Actions pins: `actions/checkout` to `v7.0.1`, `hashicorp/setup-terraform` to `v4.0.1`, `terraform-linters/setup-tflint` to `v6.3.0` (tflint `v0.64.0`).

### Fixed (PR review follow-up)

- `documentation.yaml`: checkout now pins the PR head commit SHA instead of the branch name, closing a force-push/workflow-poisoning window; added an explicit `permissions: contents: write`.
- `terraform-ci.yml`: added `timeout-minutes: 15` to every job, a top-level `permissions: contents: read`, and made the `test` job wait on `tflint` as well as `validate`.
- `release.yml`: `gh release view`/`gh release create` now pass `--repo` explicitly instead of relying on ambient `GITHUB_REPOSITORY` context.
- Removed long-dead commented-out code: the speculative `data "azurerm_app_service_environment_v3"` block in `module.tf` and the unused `ase_rg` local in `locals.tf`.
- Fixed a typo in the `ase` and `resource_groups` variable descriptions ("Servicce"/"Resouce") that had propagated into the generated README.
- Removed the hand-written `Providers` table in README.md, which duplicated (and could drift from) the terraform-docs generated one.
- Documented the required keys of the `appServicePlan` object (`resource_group`, `os_type`, `sku_name`) in the README's TFVARS Parameter table.
- Added `ESLZ/appServicePlan.tf` comment clarifying that `local.resource_groups_all`, `local.subnets`, and `local.ase_id` are expected to be defined by the calling ESLZ blueprint layer.
- Added test coverage for `per_site_scaling_enabled = true`, a `worker_count` override away from its default, and the full-ARM-ID path for `appServicePlan.resource_group` (previously untested branches).

### Notes

- No breaking changes to `azurerm_service_plan` between v4.x and v5.0 — the provider's [5.0 upgrade guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/5.0-upgrade-guide) does not list this resource under Removed Resources or Breaking Changes in Resources.
- Provider-level v5.0 changes (resource provider registration defaults, enhanced validation defaults) apply to the `provider "azurerm"` block, which is configured by module callers (L1/L2), not by this module — no action required here.
- Existing `ESLZ/*.tfvars` configurations produce an identical plan after this upgrade.
- `.terraform.lock.hcl` is gitignored by convention in this module (callers own their own lock file); consumers should run `terraform init -upgrade` after bumping to this version.
- Azure requires `worker_count` to be a multiple of the region's availability zone count when `zone_balancing_enabled = true`; this module does not currently validate that constraint (pre-existing behavior, unchanged by this upgrade).

## [1.1.0] - 2026-04-01

### Changed

- Upgraded `azurerm` provider requirement to `~> 4.0` (tested against `azurerm v4.66.0`).
- Added `premium_plan_auto_scale_enabled` argument (azurerm >= 4.x).
- Added missing infrastructure files: `providers.tf`, `.gitignore`, `.gitattributes`, `.tflint.hcl`, CI workflow, `tests/`.

## [1.0.4] and earlier

- See git history for changes prior to CHANGELOG.md being introduced.
