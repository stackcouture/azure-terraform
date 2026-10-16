locals {
  web_inbound_ports_map = {
    "100" : "80",
    "110" : "443",
    "120" : "8080",
    "130" : "22"
  }
}

locals {
  app_inbound_ports_map = {
    "100" : "80",
    "110" : "443",
    "120" : "8080",
    "130" : "22"
  }
}

locals {
  db_inbound_ports_map = {
    "100" : "3306",
    "110" : "1433",
    "120" : "5432"
  }
}