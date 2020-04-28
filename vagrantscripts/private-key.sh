# Reduce permissions on the private key for current user only
chmod 600 ~/.ssh/vagrant

# The following steps can not be automated.
# Start SSH-agent
#eval $(ssh-agent -s)

# Add private key to SSH agent
#ssh-add ~/.ssh/vagrant 
