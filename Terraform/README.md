# aansible-week12-configman
Configuration Management of Managed Nodes using Ansible Console Node


[Unit]
     Description=Stock Market Application Service
    After=network.target

[Service]
       User=ec2-user
       ExecStart=/usr/bin/java -jar /home/ec2-user/stockprice/
       Working Directory=/home/{{ node_user }}/
       Restart=always

[Install]
        WantedBy=multi-user.target