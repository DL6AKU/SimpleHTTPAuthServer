.PHONY: dist test-upload upload

pylint:
	pylint SimpleHTTPAuthServer

server: cert.pem
	python -m SimpleHTTPAuthServer 9009 user:pass

cert.pem:
	echo "Enter random data"
	openssl req -newkey rsa:2048 -new -nodes -keyout key.pem -out cert.pem

dist:
	python3 setup.py sdist

test-upload:
	twine upload dist/SimpleHTTPAuthServer-1.2.tar.gz -r pypitest

upload:
	twine upload dist/SimpleHTTPAuthServer-1.2.tar.gz -r pypi

dev:
	docker build -t simple-http-auth-server:dev .

	docker run -it --rm \
		--volume `pwd`:/usr/src/app \
		simple-http-auth-server:dev
