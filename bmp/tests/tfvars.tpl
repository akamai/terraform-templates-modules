# =================================================
# Provider / Authentication
# =================================================

# Path to your local .edgerc file
edgerc_path = "~/.edgerc"

# Section inside .edgerc to use for authentication
# Must contain client_token, client_secret, access_token, host
edgerc_section = "default"

# Akamai group name (must match exactly)
# Format usually: "<Group Name>-<ContractId>"
group_name = "GSSDEVOPS Terraform templates-1-5C13O2"

activate_to_staging = true


# =================================================
# API Definitions
# =================================================

# Map of API identifiers to OpenAPI specification files
# Key must match between 'apis' and 'operations'
apis = {
  api1 = "myapi.yml"
  
}

# Map of API identifiers to operations definition files
# Must correspond 1:1 with 'apis'
operations = {
  api1 = "operations-myapi.json"
}



# =================================================
# Security Configuration
# =================================================

# Existing AppSec configuration name
config_name = "GSS DEVOPS TERRAFORM"

# Security policy name inside the above configuration
policy_name = "Default"



# =================================================
# Bot Manager – JavaScript Injection
# =================================================

# Hostnames where JavaScript injection rule should apply
javascript_hostnames = [
  "gss-dev-ops.terra.rafa.cr"
]

# Injection behavior:
#   NEVER
#   AROUND_PROTECTED_OPERATIONS
#   ALWAYS
injection_type = "ALWAYS"



# =================================================
# Telemetry Expectations
# =================================================

# Indicates expected traffic types for transactional endpoint logic

# Inline
expect_inline_traffic = true

# SDK-based traffic 
expect_sdk_traffic = true

# Standard traffic
expect_standard_traffic = false