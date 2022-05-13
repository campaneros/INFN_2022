default: image

all: image

image:
	docker build . \
	-f ubuntu/Dockerfile \
	--build-arg BUILDER_IMAGE=rootproject/root:6.26.02-ubuntu22.04 \
	-t valsdav/vbscan-school:latest \
	-t valsdav/vbscan-school:1.2 \
	--compress
