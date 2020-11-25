PROG = const-tx-server
CFLAGS += -g -O2 -Wall
CFLAGS += -std=gnu99
LDLIBS += -lm

# CFLAGS += -pthread
# LDLIBS += -L/usr/local/lib -lmylib
# LDLIBS += -lrt
# LDFLAGS += -pthread

all: $(PROG)
OBJS += $(PROG).o
OBJS += gaussian_rand.o
OBJS += get_num.o
OBJS += my_signal.o
OBJS += prepare_send_data.o
OBJS += send_data.o

$(PROG): $(OBJS)

clean:
	rm -f *.o $(PROG)
