variable "openid_client_authorization_client_scope_policies" {
  description = <<EOT
Map of openid_client_authorization_client_scope_policies, attributes below
Required:
    - name
    - realm_id
    - resource_server_id
    - scope (block):
        - id (required)
        - required (optional)
Optional:
    - decision_strategy
    - description
    - logic
EOT

  type = map(object({
    name               = string
    realm_id           = string
    resource_server_id = string
    decision_strategy  = optional(string)
    description        = optional(string)
    logic              = optional(string)
    scope = list(object({
      id       = string
      required = optional(bool)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.openid_client_authorization_client_scope_policies : (
        length(v.scope) >= 1
      )
    ])
    error_message = "Each scope list must contain at least 1 items"
  }
  # Note: 2 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

