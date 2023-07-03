init:
	git clone https://github.com/facebookresearch/votenet.git
	wget "https://drive.google.com/uc?export=download&id=1oem0w5y5pjo2whBhAqTtuaYuyBu1OG8l" -O votenet_pretrained_models.zip
	unzip votenet_pretrained_models.zip -d ./votenet
	rm -rf votenet_pretrained_models.zip 
	grep -rl "AT_CHECK" ./votenet | xargs sed -i "s/AT_CHECK/TORCH_CHECK/g"

build:
	docker compose build

start:
	docker compose run --rm votenet_dev /bin/bash

stop:
	docker compose stop
	docker rm votenet_dev

shell:
	docker compose exec votenet_dev /bin/bash

destroy:
	@make stop
	docker rmi votenet_dev_image:latest
