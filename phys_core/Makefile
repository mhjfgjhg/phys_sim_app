CC = gcc
CFLAGS = -Wall -Wextra -fPIC -O3
LDFLAGS = -shared
TARGET = libphys_core.so

# Указываем ВСЕ исходники C-кода
SRCS = src/phys_engine.c \
	src/models/pendulum.c \
    src/solvers/euler.c

OBJS = $(SRCS:.c=.o)

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $(TARGET) $(OBJS) -lm

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) $(TARGET)