### Core / origin ###################################################

variable "etls" {
  description = "Whether the property uses Enhanced TLS (is_secure on the default rule)."
  type        = bool
  default     = false
}

variable "default_origin" {
  description = "Origin hostname from where AMD will fetch the content."
  type        = string
}

variable "additional_origins" {
  description = "Optional additional origins selected by hostname and/or path criteria."
  type = map(object({
    origin_name         = string
    forward_host_header = string
    hostname_match      = list(string)
    path_match          = list(string)
  }))
  default = {}

  validation {
    condition = alltrue([
      for origin in values(var.additional_origins) :
      try(length(origin.hostname_match) > 0, false) || try(length(origin.path_match) > 0, false)
    ])
    error_message = "Each additional origin must specify at least one non-empty hostname_match or path_match list."
  }
}

variable "forward_host_header" {
  description = "Value forwarded as the Host header to origin. Use REQUEST_HOST_HEADER, ORIGIN_HOSTNAME, or a custom hostname."
  type        = string
  default     = "REQUEST_HOST_HEADER"
}

variable "http2_enabled" {
  description = "Enable HTTP/2 between edge and origin."
  type        = bool
  default     = true
}

variable "min_tls_version" {
  description = "Minimum TLS version for edge-to-origin connections."
  type        = string
  default     = "DYNAMIC"
}

variable "verification_mode" {
  description = "Origin certificate verification mode."
  type        = string
  default     = "PLATFORM_SETTINGS"
}

### CP code (created by parent module) ###############################

variable "cpcode_id" {
  description = "Numeric ID of the CP code created by the parent module, used for reporting/billing."
  type        = number
}

variable "cpcode_name" {
  description = "Name of the CP code created by the parent module."
  type        = string
}
### AMD-specific behaviors ############################################
variable "segmented_media_optimization_behavior" {
  description = "Segmented media optimization mode: ON_DEMAND or LIVE."
  type        = string
  default     = "ON_DEMAND"

  validation {
    condition     = contains(["ON_DEMAND", "LIVE"], var.segmented_media_optimization_behavior)
    error_message = "segmented_media_optimization_behavior must be ON_DEMAND or LIVE."
  }
}

variable "origin_authentication_method" {
  description = "Authentication method used to reach the origin."
  type        = string
  default     = "AUTOMATIC"
}

variable "origin_country" {
  description = "Country of the origin, used for origin_characteristics. UNKNOWN if not applicable."
  type        = string
  default     = "UNKNOWN"
}

variable "client_country" {
  description = "Country used for client_characteristics. UNKNOWN if not applicable."
  type        = string
  default     = "UNKNOWN"
}

variable "content_catalog_size" {
  description = "Approximate size of the media catalog served by this property."
  type        = string
  default     = "UNKNOWN"
}

variable "content_type" {
  description = "Primary content resolution/type served (e.g. HD, SD, 4K)."
  type        = string
  default     = "HD"
}

variable "content_popularity_distribution" {
  description = "Expected popularity distribution of content requests."
  type        = string
  default     = "UNKNOWN"
}

variable "enable_dash" {
  description = "Whether DASH is a delivery format for this property."
  type        = bool
  default     = true
}

variable "enable_hds" {
  description = "Whether HDS is a delivery format for this property."
  type        = bool
  default     = true
}

variable "enable_hls" {
  description = "Whether HLS is a delivery format for this property."
  type        = bool
  default     = true
}

variable "enable_smooth" {
  description = "Whether Smooth Streaming is a delivery format for this property."
  type        = bool
  default     = true
}

variable "segment_duration_dash" {
  description = "Segment duration for DASH content."
  type        = string
  default     = "SEGMENT_DURATION_6S"
}

variable "segment_duration_hds" {
  description = "Segment duration for HDS content."
  type        = string
  default     = "SEGMENT_DURATION_6S"
}

variable "segment_duration_hls" {
  description = "Segment duration for HLS content."
  type        = string
  default     = "SEGMENT_DURATION_10S"
}

variable "segment_duration_smooth" {
  description = "Segment duration for Smooth Streaming content."
  type        = string
  default     = "SEGMENT_DURATION_2S"
}

variable "cache_key_query_params_behavior" {
  description = "How query parameters are treated in the cache key."
  type        = string
  default     = "IGNORE_ALL"
}

variable "enable_dynamic_throughput_optimization" {
  description = "Enable dynamic throughput optimization for adaptive bitrate delivery."
  type        = bool
  default     = true
}

variable "enable_http3" {
  description = "Enable HTTP/3 (QUIC) support."
  type        = bool
  default     = true
}

### Segmented content protection (token auth / encryption) ###########

variable "enable_segmented_content_protection" {
  description = "Master toggle for segmented content protection (token auth, media encryption)."
  type        = bool
  default     = false
}

variable "dash_media_encryption" {
  description = "Enable DASH media encryption. Only applies when enable_segmented_content_protection is true."
  type        = bool
  default     = false
}

variable "hls_media_encryption" {
  description = "Enable HLS media encryption. Only applies when enable_segmented_content_protection is true."
  type        = bool
  default     = false
}


### Debug ##############################################################
variable "enable_debug" {
  description = "Enable the enhanced_debug behavior. Off by default -- avoid baking a live debug key into every property."
  type        = bool
  default     = false
}

variable "debug_key" {
  description = "Debug key for enhanced_debug. Required only when enable_debug is true. Treat as sensitive -- pass via TF_VAR_debug_key or a secrets-managed tfvars file, never commit it."
  type        = string
  default     = null
  sensitive   = true

  validation {
    condition     = !var.enable_debug || (var.debug_key != null && length(var.debug_key) > 0)
    error_message = "debug_key must be set when enable_debug is true."
  }
}
