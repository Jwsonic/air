PRIV = $(MIX_APP_PATH)/priv/$(MIX_TARGET)
SRC = $(MIX_APP_PATH)/c_src

LDFLAGS += -shared  -dynamiclib
CFLAGS += -std=gnu99
CFLAGS ?= -O2 -Wall -Wextra -Wno-unused-parameter -pedantic

$(PRIV)/%.o: $(SRC)/%.c
	# $(CC) -O3 -g -Werror -Wall -Wextra -pedantic -o $@ $<

	$(CC) -c $(ERL_CFLAGS) $(CFLAGS) -o $@ $<

$(PRIV):
	mkdir -p $@

clean:
	$(RM) $(PRIV)/**/*.o

all: $(PRIV) $(PRIV)/pms5003