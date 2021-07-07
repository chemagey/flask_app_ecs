${jsonencode(
    [
      {
        "name": "flask_app",
        "image": "${app_image}",
        "essential": true,
        "cpu": 10,
        "memory": 512,
        "portMappings": [
          {
            "containerPort": "${app_port}",
            "hostPort": "${app_port}"
          }
        ],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-region": "${aws_region}",
                "awslogs-group": "${log_group_name}",
                "awslogs-stream-prefix": "ecs"
            }
        }
      }
    ]
)}