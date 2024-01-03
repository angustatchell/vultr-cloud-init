#!/bin/zsh

# Checking if the correct number of arguments are passed
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 [hostname] [region] [plan]"
    exit 1
fi

# Assigning arguments to variables
HOSTNAME=$1
REGION=$2
PLAN=$3

# Hardcoded cloud-init user-data
# URL of the user-data script in the GitHub repository
USER_DATA_URL="https://raw.githubusercontent.com/your_username/your_repository/branch/path/to/user-data-script.sh"

# Fetch and assign the user-data from GitHub
USER_DATA=$(curl -s $USER_DATA_URL)
if [ -z "$USER_DATA" ]; then
    echo "Failed to fetch user-data from GitHub"
    exit 1
fi

ENCODED_USER_DATA=$(echo "$USER_DATA" | base64)


# Create a new firewall group with the name fwg-${HOSTNAME}
FWG_NAME="fwg-${HOSTNAME}"

# Create a new firewall group and capture the output
FWG_OUTPUT=$(vultr-cli firewall group create -d "${FWG_NAME}")
if [ $? -ne 0 ]; then
    echo "Failed to create firewall group"
    exit 1
fi

# Extract the firewall group ID using awk
FWG_ID=$(echo "$FWG_OUTPUT" | awk '/^[0-9a-f-]{36}/ { print $1 }')
if [ -z "$FWG_ID" ]; then
    echo "Failed to extract firewall group ID"
    exit 1
fi

echo "Created new Firewall Group - ID: $FWG_ID"

# Create a new vc2 instance
vultr-cli instance create --region="${REGION}" --plan="${PLAN}" --os=2076 --host="${HOSTNAME}" --firewall-group="${FWG_ID}" --userdata="${ENCODED_USER_DATA}"

# Checking for successful creation
if [ $? -eq 0 ]; then
    echo "Instance created successfully with hostname ${HOSTNAME}"
else
    echo "Failed to create instance"
    exit 1
fi
