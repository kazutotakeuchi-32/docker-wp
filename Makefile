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
	@make open
start: 
	@make mysql_start
	@make wp_start
	@open
stop:
	@make mysql_stop
	@make wp_stop
destroy_all:
	@make wp_destroy_all
	@make mysql_rm
wp_init:
	@make wp_run
wp_run:
	docker run --name wordpress --network wordpress-network -e WORDPRESS_DB_PASSWORD=my-secret-pw -p 8080:80 -d wordpress
wp_start:
	docker start wordpress
wp_stop:
	docker stop wordpress
wp_exec:
	docker exec -it wordpress bash
wp_destroy_all:
	@make wp_rm
	@make wp_rmi
wp_rm:
	docker rm wordpress
wp_rmi:
	docker rmi wordpress
mysql_init:
	@make mysql_run
mysql_run:
	docker run --platform linux/arm64  --name mysql --network wordpress-network -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mariadb
mysql_rm:
	docker rm  mysql
mysql_start:
	docker start mysql
mysql_stop:
	docker stop mysql
mysql_exec:
	docker exec -it mysql bash
open:
	open http://localhost:8080