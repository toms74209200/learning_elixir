DOC_OUTPUT_DIR =	./outputs
DOC_DIR =			./docs


docs/index.html: outputs/index.html
	find $(DOC_OUTPUT_DIR) -type f -name "*.html" | sed -e s%./outputs/%%g | xargs -t -I{} sh -c 'inliner -nm outputs/{} > docs/{}'

outputs/index.html:
	mix docs -o $(DOC_OUTPUT_DIR)

clean:
	rm -rf $(DOC_OUTPUT_DIR)

.PHONY: clean