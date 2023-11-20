# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fnavarro <fnavarro@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/09/15 20:39:27 by fnavarro          #+#    #+#              #
#    Updated: 2023/11/07 17:36:00 by fnavarro         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #



NAME = libftprintf.a
SOURCES := $(filter-out %_bonus.c, $(wildcard *.c))
BONUS := $(wildcard *_bonus.c)
BONUS_OBJS = $(BONUS:.c=.o)
OBJECTS = $(SOURCES:.c=.o)
CFLAGS = -Wall -Wextra -Werror
CC = cc

.PHONY: all clean fclean re

all: $(NAME)

$(NAME): $(OBJECTS)
	ar -crs $(NAME) $(OBJECTS)

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@

clean:
	@rm -f $(OBJECTS)
	@echo ".o files deleted"

fclean: clean
	@rm -f $(NAME)
	@echo "directory cleaned"

re: fclean all
