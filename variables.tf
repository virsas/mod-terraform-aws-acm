variable "profile" {
  description           = "The profile from ~/.aws/credentials file used for authentication. By default it is the default profile."
  type                  = string
  default               = "default"
}

variable "accountID" {
  description           = "ID of your AWS account. It is a required variable normally used in JSON files or while assuming a role."
  type                  = string

  validation {
    condition           = length(var.accountID) == 12
    error_message       = "Please, provide a valid account ID."
  }
}

variable "region" {
  description           = "The region for the resources. By default it is eu-west-1."
  type                  = string
  default               = "eu-west-1"
}

variable "assumeRole" {
  description           = "Enable / Disable role assume. This is disabled by default and normally used for sub organization configuration."
  type                  = bool
  default               = false
}

variable "assumableRole" {
  description           = "The role the user will assume if assumeRole is enabled. By default, it is OrganizationAccountAccessRole."
  type                  = string
  default               = "OrganizationAccountAccessRole"
}

variable "create_cert" {
  description           = "If certificate should be created. By default it is set to true, only in case of import, this should be disabled."
  type                  = bool
  default               = true
}

variable "import_cert" {
  description           = "For import, please set this value to true, disable creation and provide the name of the cert in cert object."
  type                  = bool
  default               = false
}

variable "cert_path" {
  description           = "By default the certs are located in ./cert/acm directory with names *NAME* and extensions .crt .key and -ca.crt."
  type                  = string
  default               = "./certs/acm"
}

variable "cert" {
  description           = "Certificate for domain name and its alternatives. Eg.: cert = { name = 'example', domain = 'example.org', alternatives = ['*.example.org','example.com','*.example.com']}, the name part is needed for import."
  type                  = object({ name = string, domain = string, alternatives = list(string) })
}

variable "validation" {
  description           = "Method for certificate validation. DNS or EMAIL are valid options. In the case of DNS, route53 zone must be provided too. By default, we will validate the domain by email."
  type                  = string
  default               = "EMAIL"

  validation {
    condition           = contains(["DNS", "EMAIL"], var.validation)
    error_message       = "Expected values: DNS, EMAIL."
  }
}

variable "zone" {
  description           = "The Route53 zone ID, in case DNS method is selected."
  type                  = string
  default               = ""
}

variable "ttl" {
  description           = "The Route53 record TTL"
  type                  = string
  default               = "30"
}