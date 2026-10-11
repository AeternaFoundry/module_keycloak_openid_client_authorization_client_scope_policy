resource "keycloak_openid_client_authorization_client_scope_policy" "openid_client_authorization_client_scope_policies" {
  for_each = var.openid_client_authorization_client_scope_policies

  name               = each.value.name
  realm_id           = each.value.realm_id
  resource_server_id = each.value.resource_server_id
  decision_strategy  = each.value.decision_strategy
  description        = each.value.description
  logic              = each.value.logic

  dynamic "scope" {
    for_each = each.value.scope
    content {
      id       = scope.value.id
      required = scope.value.required
    }
  }
}

