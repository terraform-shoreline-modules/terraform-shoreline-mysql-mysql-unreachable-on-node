

#!/bin/bash



# Start MySQL service using systemctl

sudo systemctl start ${MYSQL_SERVICE_NAME}



# Check if the service is running

if sudo systemctl is-active ${MYSQL_SERVICE_NAME} >/dev/null 2>&1; then

    echo "MySQL service is now running."

else

    echo "Failed to start MySQL service. Please check logs for errors."

fi