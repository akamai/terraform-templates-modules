# RELEASE NOTES

## 1.1.1 (Nov 19, 2025)

#### FEATURES/ENHANCEMENTS:

* Delivery
  * Support for multiple origins based on path/hostname match.

## 1.1.0 (Nov 18, 2025)

#### FEATURES/ENHANCEMENTS:

* General
  * Upgraded all templates and modules to use Akamai provider v9.x

## 1.0.6 (Sep 24, 2025)

#### FEATURES/ENHANCEMENTS:

* Appsec
  * Introduced timeout limits for staging (15min) and production (30min) activations.

## 1.0.5 (Sep 17, 2025)

#### BUGS/FIXES:

* Delivery
  * Added Terraform's lifecycle ignore_changes to property version notes and activation notes to prevent unnecessary changes to resources only because changes to notes.

## 1.0.4 (Aug 20, 2025)

#### FEATURES/ENHANCEMENTS:

* Delivery
  * Rename variable `is_secure` as `etls`.

## 1.0.3 (Aug 4, 2025)

#### FEATURES/ENHANCEMENTS:

* Appsec
  * Implementation of the akamai_appsec_version_notes for configuration version notes.

## 1.0.2 (Jul 21, 2025)

#### FEATURES/ENHANCEMENTS:

* General
  * Introduction of change log for module versioning and tagging

## 1.0.1 (Jun 23, 2025)

#### FEATURES/ENHANCEMENTS:

* Appsec
  * Removed "Automated Shopping Cart and Sniper Bots" as this is no longer available to the product. 

## 1.0.0 (May 28, 2025)

#### FEATURES/ENHANCEMENTS:

* General
  * First official version of the PS Terraform Templates Modules ([view](https://git.source.akamai.com/projects/GSS-DEVOPS/repos/ps-terraform-templates-modules/commits/70ec0baccaac57e21f2c06971bee829473a5db62#aap%2Factivate-security%2F.terraform-docs.yaml))

* Appsec
  * AAP Terraform modules
  * AAP/ASM Terraform modules

* PAPI
  * Property manager Terraform modules
