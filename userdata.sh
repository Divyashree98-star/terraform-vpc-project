#!/bin/bash -xe

export DEBIAN_FRONTEND=noninteractive

apt update -y
apt install -y apache2

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>server1</title>
  <style>
    @keyframes colorChange {
      0% { color: red; }
      50% { color: green; }
      100% { color: blue; }
    }
    h1 {
      animation: colorChange 2s infinite;
    }
  </style>
</head>
<body>
  <h1>Hello from server1</h1>
</body>
</html>
EOF

systemctl restart apache2
systemctl enable apache2
