{
  "operations": {
    "/api/login": {
      "user_login": {
        "method": "POST",
        "purpose": "LOGIN",
        "parameters": {
          "username": {
            "path": [
              "application/json",
              "username"
            ],
            "location": "BODY"
          }
        },
        "successConditions": [
          {
            "type": "HTTP_STATUS",
            "positiveMatch": true,
            "values": [
              "200"
            ]
          }
        ]
      }
    }
  }
}