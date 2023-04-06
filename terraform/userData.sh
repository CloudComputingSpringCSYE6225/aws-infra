#!/bin/bash
    rm -f /home/ec2-user/webapp/.env
    touch /home/ec2-user/webapp/.env
    echo "AWS_BUCKET_NAME='${AWS_BUCKET_NAME}'" >> /home/ec2-user/webapp/.env
    echo "DB_USER='${DB_USER}'" >> /home/ec2-user/webapp/.env
    echo "DB_PASSWORD='${DB_PASSWORD}'" >> /home/ec2-user/webapp/.env
    echo "DB_DATABASE='${DB_DATABASE}'" >> /home/ec2-user/webapp/.env
    echo "DB_PORT='${DB_PORT}'" >> /home/ec2-user/webapp/.env
    echo "DB_HOST='${DB_HOST}'" >> /home/ec2-user/webapp/.env
    sudo systemctl restart webapp.service