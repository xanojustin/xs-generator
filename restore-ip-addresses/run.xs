// Run job to test the restore_ip_addresses function
run.job "Test Restore IP Addresses" {
  main = {
    name: "restore_ip_addresses"
    input: {
      digits: "25525511135"
    }
  }
}
