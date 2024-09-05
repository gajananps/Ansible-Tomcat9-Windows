#!/usr/bin/bash
current_path=$(pwd)
statuslog=${current_path}/status.log
errorlog=${current_path}/error.log
infolog=${current_path}/info.log

echo "Inprogress" | tee ${infolog} | tee ${statuslog} &> /dev/null
ansible-playbook inven.yaml &>> ${errorlog}
if [ ${?} -ne 0 ]
then
    echo "Failed to create inventory file" | tee -a ${errorlog} | tee ${infolog} &>/dev/null
    echo "failed" > ${statuslog}
    exit 1
fi
ansible-playbook -vv tomcat_win.yaml &>> ${errorlog}
if [ ${?} -ne 0 ]
then
    echo "Tomcat Installation Failed" | tee -a ${errorlog} | tee ${infolog} &>/dev/null
    echo "failed" > ${statuslog}
    exit 1
fi
