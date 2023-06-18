output "vm_ip_addr" {
  value       = [for vm in vsphere_virtual_machine.vm : vm.default_ip_address]
  description = "The private IP address of the vm instance."

  #depends_on = [ data.vsphere_network.network.id, ]
}