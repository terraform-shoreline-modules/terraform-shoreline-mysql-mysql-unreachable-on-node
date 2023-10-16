
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# MySQL Service Unreachable on Node.
---

This incident type refers to a situation where the node on which the MySQL service is running becomes unreachable. The incident occurs when the MySQL service cannot be found on the network, making it impossible for users to access it. This can happen due to a variety of reasons, including network connectivity issues, server downtime, or misconfiguration. It can greatly affect the performance of applications that rely on the MySQL service, leading to disruption of operations and loss of productivity.

### Parameters
```shell
export NODE_IP_ADDRESS="PLACEHOLDER"

export MYSQL_PORT="PLACEHOLDER"

export MYSQL_SERVICE_NAME="PLACEHOLDER"

export PATH_TO_MYSQL_CONFIG_FILE="PLACEHOLDER"

export PRIMARY_NODE_IP="PLACEHOLDER"

export BACKUP_NODE_IP="PLACEHOLDER"
```

## Debug

### Check if the node is up and running
```shell
ping ${NODE_IP_ADDRESS}
```

### Check if the MySQL service is running on the node
```shell
systemctl status mysql
```

### Check if the MySQL service is listening on the correct port
```shell
netstat -tulpn | grep mysql
```

### Check if the MySQL service is bound to the correct IP address
```shell
grep bind-address /etc/mysql/mysql.conf.d/mysqld.cnf
```

### Check if the MySQL service is configured to allow remote connections
```shell
grep bind-address /etc/mysql/mysql.conf.d/mysqld.cnf
```

### Check if the MySQL service is accessible from another node on the network
```shell
telnet ${NODE_IP_ADDRESS} ${MYSQL_PORT}
```

### Check if there are any firewall rules blocking the MySQL service
```shell
iptables -L | grep mysql
```

### Check if there are any network connectivity issues between the nodes
```shell
traceroute ${NODE_IP_ADDRESS}
```

## Repair

### Try to start mysql service if not already
```shell


#!/bin/bash



# Start MySQL service using systemctl

sudo systemctl start ${MYSQL_SERVICE_NAME}



# Check if the service is running

if sudo systemctl is-active ${MYSQL_SERVICE_NAME} >/dev/null 2>&1; then

    echo "MySQL service is now running."

else

    echo "Failed to start MySQL service. Please check logs for errors."

fi


```

### Verify configuration settings: Ensure that the MySQL service is configured correctly on the node. Check the configuration files to ensure that the correct settings are in place.
```shell

#!/bin/bash



# Define variables

MYSQL_CONFIG_FILE=${PATH_TO_MYSQL_CONFIG_FILE}

MYSQL_SERVICE_NAME=${MYSQL_SERVICE_NAME}



# Verify configuration settings

if ! grep -q 'key=value' "$MYSQL_CONFIG_FILE"; then

  # If the configuration file doesn't contain the expected setting, add it

  echo "key=value" >> "$MYSQL_CONFIG_FILE"

fi



# Restart the MySQL service

systemctl restart "$MYSQL_SERVICE_NAME"


```