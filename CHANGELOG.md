# Changelog

## [3.0.2](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/compare/v3.0.1...v3.0.2) (2023-12-13)


### Bug Fixes

* **role assignment:** typo which creates idempotentcy issues ([f274fe3](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/commit/f274fe3a39d773c9de1b99cbacb2f7f7232649c2))

## [3.0.1](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/compare/v3.0.0...v3.0.1) (2023-12-13)


### Bug Fixes

* typo ([3c4f643](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/commit/3c4f643b66dde34d3b502130ece2590cd8fde4e2))

## [1.1.2](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/compare/v1.1.1...v1.1.2) (2023-03-24)


### Documentation

* change module title, add repo link and PR template ([#15](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/issues/15)) ([943ac1e](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/commit/943ac1e06705560e929217fe17a8a1bd1dfef84f))

## [1.1.1](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/compare/v1.1.0...v1.1.1) (2023-03-23)


### Bug Fixes

* add version txt for release-please ([#13](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/issues/13)) ([f368ebf](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/commit/f368ebf1203923ffbc2251ade9b856249eae2516))

## [1.1.0](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/compare/v1.0.0...v1.1.0) (2023-03-23)


### Features

* expose var for argocd autosync ([#11](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/issues/11)) ([72ecafe](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/commit/72ecafe7bf1b808ccac41315788a160e9d11f5bf))

## 1.0.0 (2023-02-02)


### ⚠ BREAKING CHANGES

* move Terraform module at repository root

### Features

* add repo pipelines ([#6](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/issues/6)) ([c22c6b1](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/commit/c22c6b1d6c650630096f6158e0458a0817eca638))
* allow components to operate managed identities outside of any resource group ([#8](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/issues/8)) ([5bb47b3](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/commit/5bb47b3bee74ef37341d0503f07f177147750520))
* bump version to 4.1.14 ([c07e0f5](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/commit/c07e0f5b4fb339a833a4493176f8a505138ecf71))
* parametrize target revision ([124839e](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/commit/124839e489b013caff277f9431a69c8712e2b675))
* PoC using HCL helm values ([ccdba40](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/commit/ccdba405fc6ecac4fc5ce7cc7f3358fdf9ec207b))


### Bug Fixes

* aap-pod-identity module ([6fdb09b](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/commit/6fdb09bfc460cebee94b064661c137fbc2bbe5b1))
* add missing cluster identity role assignments ([76241c1](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/commit/76241c1e38842b4351a44f9549430aff19068c0c))
* do not delay Helm values evaluation ([0d8e2a6](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/commit/0d8e2a61580519e8f18b365486da5dc0bc0feb70))
* terraform fmt ([#10](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/issues/10)) ([9ba6634](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/commit/9ba66349e190857e0a162ffc2a69b3cca2d015c5))
* wait for app removel before deleting the project ([e4c1287](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/commit/e4c12879ecae1a0445cd149788b195e4dbc88ed8))
* work around argocd terraform provider default values ([add3588](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/commit/add35883a58a31f8c00506a7f2a7384c2b0a1a95))


### Code Refactoring

* move Terraform module at repository root ([2a9fe93](https://github.com/camptocamp/devops-stack-module-aad-pod-identity/commit/2a9fe93ccb46f1da26dd067f376d2f985fb4330f))
