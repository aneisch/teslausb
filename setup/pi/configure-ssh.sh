#!/bin/bash -eu

setup_progress "configuring ssh"

# If requested, add the desired SSH public key into /root/.ssh/authorized_keys
if [ -n "${SSH_ROOT_PUBLIC_KEY:-}" ]
then
  echo "${SSH_ROOT_PUBLIC_KEY}" > '/root/.ssh/authorized_keys'
fi

# If requested, disable SSH Password Authentication
if [ "${SSH_DISABLE_PASSWORD_AUTHENTICATION:-false}" = "true" ]
then
  sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' '/etc/ssh/sshd_config'
  systemctl reload sshd
fi

setup_progress "done configuring ssh"
