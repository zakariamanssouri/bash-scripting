#!/bin/bash

: '
 this is 
 a multiline comment
  '
: 

SERVICE_NAME="snapd.service"
VM_NAME="VM"
IMAGE_PATH="."
RAM_AMOUNT=1024
CPU_NBR=1


check_service_existence(){
  service=$(systemctl -a | grep ${SERVICE_NAME})
  if [[ -z ${service} ]];
  then 
    echo "Service Not found ,Exit!!!"
    exit 1 ;
  else 
    echo "found so next step"
  fi
}

check_kvm_service(){
  check_service_existence
  
  _serviceIsUp=$(systemctl status ${SERVICE_NAME}| grep "running")
  echo "service is :  ${_serviceIsUp}"

  if [[ -z "${_serviceIsUp}" ]]; then
    echo "service is off, starting service ${SERVICE_NAME}"
    
    if [[ $(systemctl start ${SERVICE_NAME}) -eq 0 ]] 
    then
      echo "Service is Started Succeffully" 
    else 
      echo "failed to start service"
    fi
  fi
}

create_vm_machine(){
    local VM_IMAGE_PATH="${IMAGE_PATH%/*}/${VM_NAME}.qcow2"
    #cp -v "$IMAGE_PATH" "${VM_IMAGE_PATH}"
    echo "PATH ===> ${VM_IMAGE_PATH}"
    virt-install --import --name "$VM" \
      --memory $RAM_AMOUNT --vcpus $CPU_NBR --cpu host \
      --disk $VM_IMAGE_PATH,format=qcow2,bus=virtio \
      --network bridge=virbr0,model=virtio \
      --os-type=linux \
      --os-variant=rhel7.5 \
      --graphics spice \
      --noautoconsole
}

initialize_vm_infos(){
  echo "===================================================================="
  echo -e "Enter VM NAME :\c"
  read -r VM_NAME;
  echo -e "Enter QOW2 PATH Image :\c "
  read -r IMAGE_PATH
  echo -e "Enter RAM Amount:\c"
  read -r RAM_AMOUNT
  echo -e "Enter Number of CPU:\c"
  read -r CPU_NBR
  if [[ -e $IMAGE_PATH ]];then
    create_vm_machine
  else
    echo "file not found "
  fi
  echo "===================================================================="
}

create_metadata_file(){
  touch /tmp/meta-data;
  echo -e "instance-id: ${VM_NAME}\nlocal-hostname: ${VM_NAME}" > /tmp/meta-data;
}

#call function 
check_kvm_service

initialize_vm_infos



