/*resource "akamai_botman_custom_client" "test_5a5933a4-0319-4a3b-9aa6-128cf5a066b9" {
  config_id = local.config_id
  custom_client = jsonencode(
    {
      "customClientName" : "test",
      "customClientType" : "NATIVE_APP",
      "requestConditions" : [
        {
          "name" : [
            "User-Agent"
          ],
          "nameWildcard" : true,
          "positiveMatch" : true,
          "type" : "requestHeaderCondition",
          "value" : [
            "test"
          ],
          "valueCase" : false,
          "valueWildcard" : true
        },
        {
          "name" : [
            "test"
          ],
          "nameWildcard" : true,
          "positiveMatch" : true,
          "type" : "requestHeaderCondition"
        },
        {
          "name" : [
            "test1"
          ],
          "nameWildcard" : true,
          "positiveMatch" : true,
          "type" : "requestHeaderCondition",
          "value" : [
            "test2"
          ],
          "valueCase" : false,
          "valueWildcard" : true
        }
      ]
    }
  )
}

resource "akamai_botman_custom_client_sequence" "sequence" {
  config_id = local.config_id
  custom_client_ids = [
    akamai_botman_custom_client.test_5a5933a4-0319-4a3b-9aa6-128cf5a066b9.custom_client_id
  ]
}
*/