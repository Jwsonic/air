PRIV = $(MIX_BUILD_PATH)/priv
SRC = $(MIX_BUILD_PATH)/c_src

$(PRIV)/pms5003: $(SRC)/pms5003.c
	# indent -kr -i2 -nut $< || true
	gcc -O3 -g -Werror -Wall -Wextra -pedantic -o $@ $<

all: $(PRIV)/pms5003