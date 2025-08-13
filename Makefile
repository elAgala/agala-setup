dev: clean build
	echo "Running container and testing setup script..."
	docker run -it --rm agala-setup /bin/bash -c "/fedora-setup/setup.sh"

dev-keep-alive: clean build
	echo "Running setup script and keeping container alive for testing..."
	docker run -it --name agala-setup-test agala-setup /bin/bash -c "/fedora-setup/setup.sh && echo 'Setup complete! Starting interactive shell...' && exec /bin/bash"

build:
	echo "Building Fedora test container..."
	docker build -t agala-setup .

clean:
	echo "Cleaning up containers and images..."
	docker rm -f agala-setup-test 2>/dev/null || true
	docker rmi agala-setup 2>/dev/null || true
