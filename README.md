# Palo Alto Networks PAN-OS Address Group and Dynamic Address Group (DAG) Tags module for Network Infrastructure Automation (NIA)

This Terraform module allows you to integrate [Consul](https://www.consul.io/) with Palo Alto Networks **PAN-OS** based [PA-Series and VM-Series NGFW](https://www.paloaltonetworks.com/network-security/next-generation-firewall) devices to dynamically manage the **Address Objects** based on service definition in Consul catalog. In addition, this module also manages dynamic registration/de-registration of **Dynamic Address Group (DAG) tags** based on services in Consul catalog.  

Using this Terraform module in conjunction with **consul-terraform-sync** enables teams to reduce manual ticketing processes and automate Day-2 operations related to application scale up/down in a way that is both declarative and repeatable across the organization and across multiple **PAN-OS** devices.

#### Note: This Terraform module is designed to be used only with **consul-terraform-sync**

### What is consul-terraform-sync?

The **consul-terraform-sync** runs as a daemon that enables a **publisher-subscriber** paradigm between **Consul** and **PAN-OS** based devices to support **Network Infrastructure Automation (NIA)**. 

<p align="left">
<img width="800" src="https://user-images.githubusercontent.com/11891727/95024708-b5ec5900-0639-11eb-9fa5-c11a290a5305.png"> </a>
</p>

* consul-terraform-sync **subscribes to updates from the Consul catalog** and executes one or more automation **"tasks"** with appropriate value of *service variables* based on those updates. **consul-terraform-sync** leverages [Terraform](https://www.terraform.io/) as the underlying automation tool and utilizes the Terraform provider ecosystem to drive relevant change to the network infrastructure. 

* Each task consists of a runbook automation written as a compatible **Terraform module** using resources and data sources for the underlying network infrastructure provider.

Please refer to this [link (to be updated)](https://www.consul.io/docs/download-tools) for getting started with **consul-terraform-sync**



## Compatibility
This module is meant for use with **consul-terraform-sync >= 0.1.0**, **Terraform >= 0.13** and **PAN-OS versions >= 8.0**
  

