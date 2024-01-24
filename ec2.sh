{\rtf1\ansi\ansicpg1252\cocoartf2759
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;\red11\green93\blue173;\red255\green255\blue255;}
{\*\expandedcolortbl;;\cssrgb\c0\c45098\c73333;\cssrgb\c100000\c100000\c100000;}
\paperw11900\paperh16840\margl1440\margr1440\vieww28600\viewh18000\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 #!/bin/bash\
\
# Variables\
AMI_ID="ami-0c\'947217cdde317cfec\'94\
INSTANCE_TYPE="t2.micro"\
KEY_NAME=\'93asier\'94\
SECURITY_GROUP_ID=\'93
\fs28 \cf2 \cb3 \expnd0\expndtw0\kerning0
\ul \ulc2 sg-02e6f781fd248aa6b
\fs24 \cf0 \cb1 \kerning1\expnd0\expndtw0 \ulnone \'94\
SUBNET_ID="
\fs28 \cf2 \cb3 \expnd0\expndtw0\kerning0
\ul \ulc2 subnet-093630098f334a8b2
\fs24 \cf0 \cb1 \kerning1\expnd0\expndtw0 \ulnone "  \
USER_DATA_SCRIPT="userdata.sh"  \
\
# Crear la instancia EC2\
INSTANCE_ID=$(aws ec2 run-instances \\\
  --image-id $AMI_ID \\\
  --instance-type $INSTANCE_TYPE \\\
  --key-name $KEY_NAME \\\
  --security-group-ids $SECURITY_GROUP_ID \\\
  --subnet-id $SUBNET_ID \\\
  --user-data file://$USER_DATA_SCRIPT \\\
  --query 'Instances[0].InstanceId' \\\
  --output text)\
\
# Esperar hasta que la instancia est\'e9 en ejecuci\'f3n\
echo "Esperando a que la instancia est\'e9 en ejecuci\'f3n..."\
aws ec2 wait instance-running --instance-ids $INSTANCE_ID\
\
# Obtener la direcci\'f3n IP p\'fablica de la instancia\
PUBLIC_IP=$(aws ec2 describe-instances \\\
  --instance-ids $INSTANCE_ID \\\
  --query 'Reservations[0].Instances[0].PublicIpAddress' \\\
  --output text)\
\
echo "La instancia con ID $INSTANCE_ID est\'e1 en ejecuci\'f3n."\
echo "Direcci\'f3n IP p\'fablica: $PUBLIC_IP"\
\
\
}