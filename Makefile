build: build-docker build-mkdocs

run: run-mkdocs

publish: publish-mkdocs

clean:
	rm -rf output

build-docker:
	docker build -t intro-to-python-workshop .



  
run-mkdocs:
	docker run --rm -it -v `pwd`/docs:/data -p 8000:8000 intro-to-python-workshop mkdocs serve -a 0.0.0.0:8000

build-mkdocs: clean
	docker run --rm -it -v `pwd`/docs:/data intro-to-python-workshop mkdocs build 
	mkdir -p output/
	cp -r  docs/site/* output/

publish-mkdocs:
	docker run --rm -it -v `pwd`:/data -v "$(HOME)/.ssh":/root/.ssh intro-to-python-workshop mkdocs gh-deploy -f docs/mkdocs.yml

