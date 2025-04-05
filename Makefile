IMAGE_NAME = pwn
CONTAINER_NAME = pwn-container

build:
	docker buildx build --platform=linux/amd64 -t $(IMAGE_NAME) .

run:
	@if docker ps -a --format '{{.Names}}' | grep -q "^$(CONTAINER_NAME)$$"; then \
		echo "🔁 컨테이너가 이미 존재합니다. 다시 실행합니다."; \
		docker start -ai $(CONTAINER_NAME); \
	else \
		echo "🚀 새 컨테이너를 생성합니다."; \
		docker run --platform=linux/amd64 -it --name $(CONTAINER_NAME) $(IMAGE_NAME); \
	fi

save:
	docker commit $(CONTAINER_NAME) $(IMAGE_NAME)-tmp
	docker rmi -f $(IMAGE_NAME)
	docker tag $(IMAGE_NAME)-tmp $(IMAGE_NAME)
	docker rmi -f $(IMAGE_NAME)-tmp

clean:
	docker rm -f $(CONTAINER_NAME)
	docker rmi -f $(IMAGE_NAME)