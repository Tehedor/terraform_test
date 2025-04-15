resource "null_resource" "generate_inventory" {
  provisioner "local-exec" {
    command = <<EOT
      sleep 10
      echo "Generando inventario..."
      terraform output -json > ../../../inventory/outputs.json
    EOT
  }
}