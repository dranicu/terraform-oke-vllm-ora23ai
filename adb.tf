#lookup for secret
data "oci_secrets_secretbundle" "bundle" {
  secret_id = var.adb_admin_password
}


resource "oci_database_autonomous_database" "tf_database_autonomous_database" {
       admin_password = base64decode(data.oci_secrets_secretbundle.bundle.secret_bundle_content.0.content)
       compartment_id = var.compartment_id
       compute_count = var.adb_compute_count
       compute_model = "ECPU"
       data_storage_size_in_tbs = var.adb_data_storage_size_in_tbs
       db_name = var.adb_db_name
       db_version = "23ai"
       db_workload = "DW"
       display_name = var.adb_display_name
       is_dedicated = false
       is_mtls_connection_required = false
       license_model = "LICENSE_INCLUDED"
       whitelisted_ips = [module.oke.vcn_id]
       is_data_guard_enabled = false
       is_local_data_guard_enabled = false
}
