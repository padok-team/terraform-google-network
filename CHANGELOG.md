# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

## [4.3.0](https://github.com/padok-team/terraform-google-network/compare/v4.2.0...v4.3.0) (2024-10-21)


### Features

* **upgrade:** upgrade hashicorp/google provider to version = ~&gt; 6.0 and hashicorp/random to version = ~> 3.1 ([055dc12](https://github.com/padok-team/terraform-google-network/commit/055dc120f22563bb1ac6795a59c48295c6b6cf2b))

## [4.2.0](https://github.com/padok-team/terraform-google-network/compare/v4.1.0...v4.2.0) (2024-06-28)


### Features

* bump provider & module version ([d0c31f7](https://github.com/padok-team/terraform-google-network/commit/d0c31f79f44a2a968957c46ffd05f3fd3e08651d))

## [4.1.0](https://github.com/padok-team/terraform-google-network/compare/v4.0.0...v4.1.0) (2024-05-31)


### Features

* add boostrap ([67138ae](https://github.com/padok-team/terraform-google-network/commit/67138ae1df72f5b2f7ec6f1216cc547fd97d5d15))
* add oicd to ci job ([7fc981b](https://github.com/padok-team/terraform-google-network/commit/7fc981b672aa11d0768e9da25c668e64410e42f5))
* add terratest.yaml github action workflow ([a275f05](https://github.com/padok-team/terraform-google-network/commit/a275f0528d9d1b96d452921497e654b1089443b7))
* add testing ([394107e](https://github.com/padok-team/terraform-google-network/commit/394107e2de843c77532381d2024cb31f69e6c85c))
* added purposes to subnet ([e5b366c](https://github.com/padok-team/terraform-google-network/commit/e5b366ceb7207ba55e64b8591c5547fd1f91ff2a))
* **checkov:** skip CKV_TF_1 and use version instead of commit hash ([675c97d](https://github.com/padok-team/terraform-google-network/commit/675c97deda8952e3acc906d0cb0f9abdf14524cc))
* **terratest:** add tests folder with default terraform_apply_test ([7538389](https://github.com/padok-team/terraform-google-network/commit/75383895d82383e2ca9d267be0f179842ec470bb))


### Bug Fixes

* ci ([89d65bb](https://github.com/padok-team/terraform-google-network/commit/89d65bb0965ee6c607f510b76c4f73ca758ef04b))
* ci ([3abff71](https://github.com/padok-team/terraform-google-network/commit/3abff7161ee4e320599d34bf6bdd4f1affa6d597))
* clean code ([1f7e328](https://github.com/padok-team/terraform-google-network/commit/1f7e32842b24e9194422527c59847f068b87a082))
* correct flag ([dada8a0](https://github.com/padok-team/terraform-google-network/commit/dada8a0e409f031e24965b084fb6e7187bf252a9))
* pipeline ([cd6b2bf](https://github.com/padok-team/terraform-google-network/commit/cd6b2bf5db2291471dc73dc666423e2d0975e26f))
* remove push restriction ([a70e256](https://github.com/padok-team/terraform-google-network/commit/a70e256352b9647202095a7ce400999e79032fd8))

## [4.0.0](https://github.com/padok-team/terraform-google-network/compare/v3.2.0...v4.0.0) (2023-04-11)


### ⚠ BREAKING CHANGES

* **access_connector:** fix naming to avoid conflict with subnet indexes

### Bug Fixes

* **access_connector:** fix naming to avoid conflict with subnet indexes ([b4e2021](https://github.com/padok-team/terraform-google-network/commit/b4e2021a3c08ec3fbde9b4b85ef2ffbcfbbe730b))

## [3.2.0](https://github.com/padok-team/terraform-google-network/compare/v3.1.0...v3.2.0) (2023-01-27)


### Features

* **vpc_connector:** add specs ([58bde72](https://github.com/padok-team/terraform-google-network/commit/58bde72def7337829160632291dbd2075f0743d9))

## [3.1.0](https://github.com/padok-team/terraform-google-network/compare/v3.0.0...v3.1.0) (2023-01-25)


### Features

* **examples:** adapt examples for custom nat gateways ([cec8f94](https://github.com/padok-team/terraform-google-network/commit/cec8f942bfa2fb21a5353d842806c2f3a372d27d))
* **hashicorp/google:** bump version to 4.49 ([b91c88d](https://github.com/padok-team/terraform-google-network/commit/b91c88d6a49faadbe404d56603bfe5510f63ef29))
* **main:** allow putting custom config for nat gateways ([060bdc4](https://github.com/padok-team/terraform-google-network/commit/060bdc4f589143a9b66891c79f3db31e9d688713))
* **main:** toset regions in locals ([4389d7b](https://github.com/padok-team/terraform-google-network/commit/4389d7b1c3d497b5d39ca0d98e5bba1d67343b98))

### [2.0.4](https://github.com/padok-team/terraform-google-network/compare/v2.0.3...v2.0.4) (2022-01-28)


### Bug Fixes

* **exemple/cloudrun:** output module does not exist ([0d1d891](https://github.com/padok-team/terraform-google-network/commit/0d1d8914fdb75af67f942d25b59742dcd02f3bbb))
* remove unused variables ([4fcd47a](https://github.com/padok-team/terraform-google-network/commit/4fcd47a187143974d8f2f4ee4401bf07ce3eae86))

### [1.1.1](https://github.com/padok-team/terraform-google-network/compare/v2.0.3...v1.1.1) (2022-01-28)


### Bug Fixes

* **exemple/cloudrun:** output module does not exist ([0d1d891](https://github.com/padok-team/terraform-google-network/commit/0d1d8914fdb75af67f942d25b59742dcd02f3bbb))
* remove unused variables ([4fcd47a](https://github.com/padok-team/terraform-google-network/commit/4fcd47a187143974d8f2f4ee4401bf07ce3eae86))
