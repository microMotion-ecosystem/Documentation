ssh-keygen -t ed25519 -C "striker.h@gmail.com"
/home/ubuntu/.ssh/pinkstaging2_github_strikerh

# Add the key to the ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/pinkstaging2_github_strikerh

