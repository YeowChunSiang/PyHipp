#!/bin/bash
ssh -o StrictHostKeyChecking=no -i /data/MyKeyPair.pem ec2-user@47.129.234.132 "source ~/.bashrc; /home/ec2-user/miniconda3/bin/pcluster update-compute-fleet --status STOP_REQUESTED -n MyCluster02; ~/update_snapshot.sh data 2 MyCluster02"
