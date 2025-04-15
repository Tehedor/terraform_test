terraform {
  backend "vault" {
    address = "http://kmaster01.lab.local:8200" # Dirección de tu servidor Vault
    token   = "pruebas123"                     # Token raíz de Vault (solo para pruebas, no recomendado en producción)
    path    = "terraform/state/mi-proyecto"    # Ruta donde se almacenará el estado en Vault
    # namespace = "<tu_namespace_vault>"       # Opcional, si usas namespaces en Vault
  }
}