// เช็คเวอร์ชั่น Docker
docker -v 

// ตรวจสอบ Docker ว่าทำงานถูกต้องไหม
docker run hello-world

// ดูคอนเทนเนอร์ทั้งหมดที่กำลังทำงานอยู่
docker ps --all

// ดูอิมเมจทั้งหมดที่มีอยู่ในเครื่อง
docker images

// รันคอนเทนเนอร์จากอิมเมจ busybox
docker run busybox

// รันคอนเทนเนอร์จากอิมเมจ busybox และใช้คำสั่ง ping เพื่อเช็คการเชื่อมต่ออินเทอร์เน็ต
docker run busybox ping google.com

// หยุดคอนเทนเนอร์ที่กำลังทำงานอยู่
docker stop <container_id or name>  

// ดึงอิมเมจจาก Docker Hub มาไว้ในเครื่อง
docker pull <container_id or name> 

// สร้างคอนเทนเนอร์จากอิมเมจที่มีอยู่แล้ว
docker create <container_id or name> 
docker create busybox ping google.com

// เริ่มคอนเทนเนอร์ที่ถูกสร้างขึ้น
docker start <container_id or name>
docker start 4eb079482233

// ตรวจสอบสถานะของคอนเทนเนอร์ที่กำลังทำงานอยู่
docker ps

// ลบคอนเทนเนอร์ที่ไม่ต้องการ
docker rm <container_id or name>

// ลบอิมเมจที่ไม่ต้องการ
docker system prune

// รันคอนเทนเนอร์จากอิมเมจ nginx โดยจะทำการเปิดพอร์ต 80 ของคอนเทนเนอร์ไปยังพอร์ต 8080 ของเครื่องโฮสต์
docker run nginx

// คำสั่งนี้จะเปิดเชลล์ภายในคอนเทนเนอร์ที่กำลังทำงานอยู่ เพื่อให้เราสามารถทำงานภายในคอนเทนเนอร์ได้โดยตรง
docker exec -it <container_id or name> sh 

// หากคอนเทนเนอร์นั้นมีเชลล์ของคอนเทนเนอร์ที่กำลังทำงานอยู่ bash ให้ใช้คำสั่งนี้แทน
docker exit <container_id or name> bash

cd /usr/share/nginx/html
cat index.html 

// คำสั่งนี้จะเปิดพอร์ต 80 ของคอนเทนเนอร์ nginx ไปยังพอร์ต 80 ของเครื่องโฮสต์ ทำให้เราสามารถเข้าถึงเว็บไซต์ที่รันอยู่ในคอนเทนเนอร์ผ่านทางเบราว์เซอร์ได้โดยการเข้าไปที่ http://localhost:80 หรือ http://
docker run -p 80:80 nginx 

// คำสั่งนี้จะรันคอนเทนเนอร์ nginx ในโหมด detached (ทำงานในพื้นหลัง) และเปิดพอร์ต 80 ของคอนเทนเนอร์ไปยังพอร์ต 80 ของเครื่องโฮสต์
docker run -d -p 8000:80 nginx 

// เหมือน docker image
docker image ls 

// ตรวจสอบรายละเอียดของอิมเมจ nginx ที่ดึงมา
docker image inspect nginx 

// ลบอิมเมจที่ไม่ต้องการ
docker image rm <image_id or name> 

// ดึงอิมเมจ WordPress, mysql:5.7 จาก Docker Hub มาไว้ในเครื่อง
docker pull wordpress 
docker pull mysql:5.7
docker pull phpmyadmin/phpmyadmin

// create network
// สร้างเครือข่าย Docker ชื่อ "wordpress" เพื่อให้คอนเทนเนอร์ต่าง ๆ สามารถสื่อสารกันได้
docker network create wordpress
docker network ls

docker run --name mysql --network wordpress -e MYSQL_ROOT_PASSWORD=1111 -e MYSQL_DATABASE=wordpress_db -e MYSQL_USER=wordpress -e MYSQL_PASSWORD=wordpress -d mysql:5.7
docker run --name pma --network wordpress -p 8888:80 -e PMA_ARBITRARY=1 -d phpmyadmin/phpmyadmin
docker run -d --name wordpress --network wordpress -p 888:80 -e WORDPRESS_DB_HOST=mysql -e WORDPRESS_DB_USER=wordpress -e WORDPRESS_DB_PASSWORD=wordpress -e WORDPRESS_DB_NAME=wordpress_db wordpress 

// join network
// รันคอนเทนเนอร์ MySQL และเชื่อมต่อกับเครือข่าย "wordpress" ที่สร้างขึ้น
docker network connect wordpress mysql // เชื่อมต่อคอนเทนเนอร์ mysql กับเครือข่าย wordpress
docker network connect wordpress pma // เชื่อมต่อคอนเทนเนอร์ phpmyadmin กับเครือข่าย wordpress

