# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fnavarro <fnavarro@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/09/15 20:39:27 by fnavarro          #+#    #+#              #
#    Updated: 2023/11/20 18:46:04 by fnavarro         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #



NAME = libftprintf.a
SOURCES := $(filter-out %_bonus.c, $(wildcard *.c))
OBJECTS = $(SOURCES:.c=.o)
CFLAGS = -Wall -Wextra -Werror
CC = cc
LFT = 	libft/
LIB =	$(LFT)libft.a
LFSRC =	$(filter-out %_bonus.c, $(wildcard $(LFT)*.c))
LFTOB = $(LFSRC:.c=.o)

.PHONY: all clean fclean re

all: $(NAME)

$(NAME): $(OBJECTS) $(LIB)
	ar -crs $(NAME) $(OBJECTS)

$(LIB):
	@make re -C $(LFT)

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@

printf: main.c $(NAME) $(LIB)
	$(CC) $(CFLAGS) -o printf main.c $(NAME) $(LIB)

clean:
	@rm -f $(OBJECTS)
	@echo ".o files deleted"

fclean: clean
	@rm -f $(NAME)
	@echo "directory cleaned"

re: fclean all
