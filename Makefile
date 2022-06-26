net_ls: 
	docker network ls
net_create:
	docker network create wordpress-network
net_rm:
	docker network rm wordpress-network
inspect:
	docker network inspect wordpress-network
init:
	@make mysql_init
	@make wp_init
	@open
start: 
	@make mysql_start
	@make wp_start
	@open
wp_init:
	@make wp_run
wp_run:
	docker run --name wordpress --network wordpress-network -e WORDPRESS_DB_PASSWORD=my-secret-pw -p 8080:80 -d wordpress
wp_start:
	docker start wordpress
wp_stop:
	docker stop wordpress
mysql_init:
	@make mysql_run
mysql_run:
	docker run --name mysql --network wordpress-network -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:5.7
mysql_start:
	docker start mysql
mysql_stop:
	docker stop mysql
open:
	open http://localhost:8080
