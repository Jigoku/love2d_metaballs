all:
	cd src/ && zip -9 -q -r ../package/metaballs.love . -x \*.git*

clean:
	rm -rf package/metaballs.love
