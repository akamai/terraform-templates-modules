openapi: 3.0.1
info:
  title: api/test-${MATRIX_NAME}
servers:
  - url: gss-dev-ops.terra.rafa.cr/api
x-akamai-api-definitions:
  contractId: 1-5C13O2
  groupId: 315874
  matchCaseSensitive: false
  constraints:
    enforceOn:
      request: true
paths:
  /api/${MATRIX_NAME}/login:
    x-akamai-api-definitions-resource:
      name: user_login
    post:
      parameters:
        - name: token
          in: cookie
          required: true
          schema:
            type: string
        - name: token2
          in: query
          required: true
          schema:
            type: integer
        - name: token3
          in: header
          required: true
          schema:
            type: number
        - name: token4
          in: cookie
          required: true
          schema:
            type: boolean
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                username:
                  type: string
                password:
                  type: string