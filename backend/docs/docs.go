// Code generated by swaggo/swag. DO NOT EDIT.

package docs

import "github.com/swaggo/swag"

const docTemplate = `{
    "schemes": {{ marshal .Schemes }},
    "swagger": "2.0",
    "info": {
        "description": "{{escape .Description}}",
        "title": "{{.Title}}",
        "contact": {
            "name": "Dang Dao",
            "email": "ddang.daodang@gmail.com"
        },
        "version": "{{.Version}}"
    },
    "host": "{{.Host}}",
    "basePath": "{{.BasePath}}",
    "paths": {
        "/auth/all": {
            "get": {
                "description": "Get the list of all users",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "Auth"
                ],
                "summary": "Get users",
                "parameters": [
                    {
                        "type": "integer",
                        "format": "page",
                        "description": "page number",
                        "name": "page",
                        "in": "query"
                    },
                    {
                        "type": "integer",
                        "format": "size",
                        "description": "number of elements per page",
                        "name": "size",
                        "in": "query"
                    },
                    {
                        "type": "integer",
                        "format": "orderBy",
                        "description": "filter name",
                        "name": "orderBy",
                        "in": "query"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "OK",
                        "schema": {
                            "$ref": "#/definitions/models.UsersList"
                        }
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "schema": {
                            "$ref": "#/definitions/httpErrors.RestError"
                        }
                    }
                }
            }
        },
        "/auth/login": {
            "post": {
                "description": "login user, returns user and set session",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "Auth"
                ],
                "summary": "Login new user",
                "responses": {
                    "200": {
                        "description": "OK",
                        "schema": {
                            "$ref": "#/definitions/models.User"
                        }
                    }
                }
            }
        },
        "/auth/logout": {
            "post": {
                "description": "logout user removing session",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "Auth"
                ],
                "summary": "Logout user",
                "responses": {
                    "200": {
                        "description": "ok",
                        "schema": {
                            "type": "string"
                        }
                    }
                }
            }
        },
        "/auth/me": {
            "get": {
                "description": "Get current user by id",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "Auth"
                ],
                "summary": "Get user by id",
                "responses": {
                    "200": {
                        "description": "OK",
                        "schema": {
                            "$ref": "#/definitions/models.User"
                        }
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "schema": {
                            "$ref": "#/definitions/httpErrors.RestError"
                        }
                    }
                }
            }
        },
        "/auth/register": {
            "post": {
                "description": "register new user, returns user and token",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "Auth"
                ],
                "summary": "Register new user",
                "responses": {
                    "201": {
                        "description": "Created",
                        "schema": {
                            "$ref": "#/definitions/models.User"
                        }
                    }
                }
            }
        },
        "/auth/token": {
            "get": {
                "description": "Get CSRF token, required auth session cookie",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "Auth"
                ],
                "summary": "Get CSRF token",
                "responses": {
                    "200": {
                        "description": "Ok",
                        "schema": {
                            "type": "string"
                        }
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "schema": {
                            "$ref": "#/definitions/httpErrors.RestError"
                        }
                    }
                }
            }
        },
        "/auth/{id}": {
            "get": {
                "description": "get string by ID",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "Auth"
                ],
                "summary": "get user by id",
                "parameters": [
                    {
                        "type": "integer",
                        "description": "user_id",
                        "name": "id",
                        "in": "path",
                        "required": true
                    }
                ],
                "responses": {
                    "200": {
                        "description": "OK",
                        "schema": {
                            "$ref": "#/definitions/models.User"
                        }
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "schema": {
                            "$ref": "#/definitions/httpErrors.RestError"
                        }
                    }
                }
            },
            "put": {
                "description": "update existing user",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "Auth"
                ],
                "summary": "Update user",
                "parameters": [
                    {
                        "type": "integer",
                        "description": "user_id",
                        "name": "id",
                        "in": "path",
                        "required": true
                    }
                ],
                "responses": {
                    "200": {
                        "description": "OK",
                        "schema": {
                            "$ref": "#/definitions/models.User"
                        }
                    }
                }
            },
            "delete": {
                "description": "some description",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "Auth"
                ],
                "summary": "Delete user account",
                "parameters": [
                    {
                        "type": "integer",
                        "description": "user_id",
                        "name": "id",
                        "in": "path",
                        "required": true
                    }
                ],
                "responses": {
                    "200": {
                        "description": "ok",
                        "schema": {
                            "type": "string"
                        }
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "schema": {
                            "$ref": "#/definitions/httpErrors.RestError"
                        }
                    }
                }
            }
        },
        "/auth/{name}": {
            "get": {
                "description": "Find user by name",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "Auth"
                ],
                "summary": "Find by name",
                "parameters": [
                    {
                        "type": "string",
                        "format": "username",
                        "description": "username",
                        "name": "name",
                        "in": "query"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "OK",
                        "schema": {
                            "$ref": "#/definitions/models.UsersList"
                        }
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "schema": {
                            "$ref": "#/definitions/httpErrors.RestError"
                        }
                    }
                }
            }
        },
        "/auth/{station_code}": {
            "get": {
                "description": "Find user by station code",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "Auth"
                ],
                "summary": "Find by station code",
                "responses": {
                    "200": {
                        "description": "OK",
                        "schema": {
                            "$ref": "#/definitions/models.UsersList"
                        }
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "schema": {
                            "$ref": "#/definitions/httpErrors.RestError"
                        }
                    }
                }
            }
        },
        "/auth/{user_name}": {
            "get": {
                "description": "Find user by name",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "Auth"
                ],
                "summary": "Find by name",
                "parameters": [
                    {
                        "type": "string",
                        "format": "username",
                        "description": "username",
                        "name": "name",
                        "in": "query"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "OK",
                        "schema": {
                            "$ref": "#/definitions/models.User"
                        }
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "schema": {
                            "$ref": "#/definitions/httpErrors.RestError"
                        }
                    }
                }
            }
        },
        "/insp/": {
            "post": {
                "description": "Create inspection",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "Insp"
                ],
                "summary": "Create inspection",
                "operationId": "Create inspection",
                "parameters": [
                    {
                        "type": "string",
                        "format": "user_id",
                        "description": "user id",
                        "name": "user_id",
                        "in": "path",
                        "required": true
                    }
                ],
                "responses": {
                    "200": {
                        "description": "OK",
                        "schema": {
                            "$ref": "#/definitions/models.Inspection"
                        }
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "schema": {
                            "$ref": "#/definitions/httpErrors.RestError"
                        }
                    }
                }
            }
        },
        "/insp/all": {
            "get": {
                "description": "Get the list of all inspections",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "Insp"
                ],
                "summary": "Get all inspections following pagination query(size, page, orderBy",
                "operationId": "GetAll",
                "parameters": [
                    {
                        "type": "integer",
                        "format": "page",
                        "description": "page number",
                        "name": "page",
                        "in": "query"
                    },
                    {
                        "type": "integer",
                        "format": "size",
                        "description": "number of elements per page",
                        "name": "size",
                        "in": "query"
                    },
                    {
                        "type": "integer",
                        "format": "orderBy",
                        "description": "filter name",
                        "name": "orderBy",
                        "in": "query"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "OK",
                        "schema": {
                            "$ref": "#/definitions/models.InspectionsList"
                        }
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "schema": {
                            "$ref": "#/definitions/httpErrors.RestError"
                        }
                    }
                }
            }
        },
        "/insp/registration/{registration_id}": {
            "get": {
                "description": "Get inspection by registration id",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "Insp"
                ],
                "summary": "Get inspection by registration id",
                "operationId": "GetByRegistrationID",
                "parameters": [
                    {
                        "type": "string",
                        "format": "registration_id",
                        "description": "registration id",
                        "name": "registration_id",
                        "in": "path",
                        "required": true
                    }
                ],
                "responses": {
                    "200": {
                        "description": "OK",
                        "schema": {
                            "$ref": "#/definitions/models.InspectionsList"
                        }
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "schema": {
                            "$ref": "#/definitions/httpErrors.RestError"
                        }
                    }
                }
            }
        },
        "/insp/station/{station_code}": {
            "get": {
                "description": "Get inspection by station code",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "Insp"
                ],
                "summary": "Get inspection by station code",
                "operationId": "GetByStationCode",
                "parameters": [
                    {
                        "type": "string",
                        "format": "station_code",
                        "description": "station code",
                        "name": "station_code",
                        "in": "path",
                        "required": true
                    }
                ],
                "responses": {
                    "200": {
                        "description": "OK",
                        "schema": {
                            "$ref": "#/definitions/models.InspectionsList"
                        }
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "schema": {
                            "$ref": "#/definitions/httpErrors.RestError"
                        }
                    }
                }
            }
        },
        "/insp/{inspection_id}": {
            "get": {
                "description": "Get inspection by ID",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "Insp"
                ],
                "summary": "Get inspection by ID",
                "operationId": "GetByID",
                "responses": {
                    "200": {
                        "description": "OK",
                        "schema": {
                            "$ref": "#/definitions/models.InspectionsList"
                        }
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "schema": {
                            "$ref": "#/definitions/httpErrors.RestError"
                        }
                    }
                }
            },
            "put": {
                "description": "Update inspection",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "Insp"
                ],
                "summary": "Update inspection",
                "operationId": "Update",
                "parameters": [
                    {
                        "type": "string",
                        "format": "inspection_id",
                        "description": "inspection id",
                        "name": "inspection_id",
                        "in": "path",
                        "required": true
                    }
                ],
                "responses": {
                    "200": {
                        "description": "OK",
                        "schema": {
                            "$ref": "#/definitions/models.Inspection"
                        }
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "schema": {
                            "$ref": "#/definitions/httpErrors.RestError"
                        }
                    }
                }
            },
            "delete": {
                "description": "Delete inspection",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "Insp"
                ],
                "summary": "Delete inspection",
                "operationId": "Delete",
                "parameters": [
                    {
                        "type": "string",
                        "format": "inspection_id",
                        "description": "inspection id",
                        "name": "inspection_id",
                        "in": "path",
                        "required": true
                    }
                ],
                "responses": {
                    "200": {
                        "description": "OK",
                        "schema": {
                            "type": "string"
                        }
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "schema": {
                            "$ref": "#/definitions/httpErrors.RestError"
                        }
                    }
                }
            }
        }
    },
    "definitions": {
        "httpErrors.RestError": {
            "type": "object",
            "properties": {
                "error": {
                    "type": "string"
                },
                "status": {
                    "type": "integer"
                }
            }
        },
        "models.Inspection": {
            "type": "object",
            "properties": {
                "expiry_date": {
                    "type": "string"
                },
                "inspection_date": {
                    "type": "string"
                },
                "inspection_id": {
                    "type": "integer"
                },
                "registration_id": {
                    "type": "string"
                },
                "station_code": {
                    "type": "string"
                }
            }
        },
        "models.InspectionsList": {
            "type": "object",
            "properties": {
                "has_more": {
                    "type": "boolean"
                },
                "inspections": {
                    "type": "array",
                    "items": {
                        "$ref": "#/definitions/models.Inspection"
                    }
                },
                "page": {
                    "type": "integer"
                },
                "size": {
                    "type": "integer"
                },
                "total_count": {
                    "type": "integer"
                },
                "total_pages": {
                    "type": "integer"
                }
            }
        },
        "models.User": {
            "type": "object",
            "required": [
                "first_name",
                "last_name",
                "password"
            ],
            "properties": {
                "about": {
                    "type": "string",
                    "maxLength": 1024
                },
                "avatar": {
                    "type": "string",
                    "maxLength": 512
                },
                "created_at": {
                    "type": "string"
                },
                "email": {
                    "type": "string",
                    "maxLength": 60
                },
                "first_name": {
                    "type": "string",
                    "maxLength": 30
                },
                "identity_no": {
                    "type": "string",
                    "maxLength": 20
                },
                "last_name": {
                    "type": "string",
                    "maxLength": 30
                },
                "login_date": {
                    "type": "string"
                },
                "password": {
                    "type": "string",
                    "minLength": 6
                },
                "phone_number": {
                    "type": "string",
                    "maxLength": 20
                },
                "role": {
                    "type": "string",
                    "maxLength": 10
                },
                "station_code": {
                    "type": "string",
                    "maxLength": 20
                },
                "updated_at": {
                    "type": "string"
                },
                "user_id": {
                    "type": "string"
                },
                "user_name": {
                    "type": "string",
                    "maxLength": 60
                }
            }
        },
        "models.UsersList": {
            "type": "object",
            "properties": {
                "has_more": {
                    "type": "boolean"
                },
                "page": {
                    "type": "integer"
                },
                "size": {
                    "type": "integer"
                },
                "total_count": {
                    "type": "integer"
                },
                "total_pages": {
                    "type": "integer"
                },
                "users": {
                    "type": "array",
                    "items": {
                        "$ref": "#/definitions/models.User"
                    }
                }
            }
        }
    }
}`

// SwaggerInfo holds exported Swagger Info so clients can modify it
var SwaggerInfo = &swag.Spec{
	Version:          "1.0",
	Host:             "",
	BasePath:         "/api/v1",
	Schemes:          []string{},
	Title:            "RegistryTotal REST API",
	Description:      "RegistryTotal Golang REST API",
	InfoInstanceName: "swagger",
	SwaggerTemplate:  docTemplate,
	LeftDelim:        "{{",
	RightDelim:       "}}",
}

func init() {
	swag.Register(SwaggerInfo.InstanceName(), SwaggerInfo)
}
