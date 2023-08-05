DOC_OUTPUT_DIR =	./outputs
DOC_DIR =			./docs


docs/index.html: outputs/index.html
	inliner -nm $(DOC_OUTPUT_DIR)/index.html > docs/index.html
	inliner -nm $(DOC_OUTPUT_DIR)/api-reference.html > docs/api-reference.html

outputs/index.html:
	mix docs -o $(DOC_OUTPUT_DIR)

clean:
	rm -rf $(DOC_OUTPUT_DIR)

.PHONY: clean