# printf
My own implementation of printf in C for the 42 programming school.

Also in this README.md I will share my notes on how to build your own printf function.

# How to build your own printf

These are the steps and the reasoning I did for implementing my own version of printf.

## Project Structure

First, I created the following project structure:

```
ft_printf.c - where I will put the code of the main printf function
ft_printf.h - where I will define the functions that will be part of the library used to build my printf
Makefile - where I define the rules to build the library and generate executables.
```

### FT_PRINTF.H

I will add the stdarg.h library to my `.h` to enable variadict functions.

Variadic functions are functions which may take a variable number of arguments and are declared with an ellipsis (...) in place of the last parameter. Printf is the most common example of variadic functions.

```
# include <stdarg.h>
```


### Printf prototype
The function prototype will be:

```
int	ft_printf(char const *format, ...)
{
	
}
```

- `The function return the number of characters printed (not including the trailing '\0' used to end output to strings)[FROM MAN]` as an integer (int).
- the `...` in the arguments represent that printf may take a variable number of arguments (is a variadic function).

## First tests

I am going to use the [francinette](https://github.com/xicodomingues/francinette) project for testing since it allows me to easily check that the function is working as expected.

After creating the following files:
ft_printf.c
```
int	ft_printf(char const *format, ...)
{
	if (!format)
		return (1);
	return (0);
}

```
ft_printf.h
```
#ifndef FT_PRINTF_H
# define FT_PRINTF_H 1

# include <stdlib.h>
# include <stdarg.h>

int	ft_printf(char const *format, ...);

#endif
```

makefile
```
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
```

I can run (after installing francinette) the tests:

```
paco
```

Obviously pretty much all the tests will fail but this can be a good start point to work with something that is not a blank page.

## Main loop

This is copied from the printf man page:

```
The printf utility formats and prints its arguments, after the first, under control of the format.  The format is a character string which contains three types of objects: plain characters, which are simply copied to standard output, character escape sequences which are converted and copied to the standard output, and
     format specifications, each of which causes printing of the next successive argument.

     The arguments after the first are treated as strings if the corresponding format is either c, b or s; otherwise it is evaluated as a C constant, with the following extensions:

           o   A leading plus or minus sign is allowed.
           o   If the leading character is a single or double quote, the value is the character code of the next character.

     The format string is reused as often as necessary to satisfy the arguments.  Any extra format specifications are evaluated with zero or the null string.
```

So, to start, we need to implement a function that can receive multiple arguments and will print the first of them (the format string) as it is. This will cover the first type of objects in the format string, plain characters. After that. We can continue by implementing escape sequence characters such as the tab character or the new line character. Finally, we will implement the part of replacing the format specifications with the other arguments that the function receives.

Is interesting from this man page to understand that the arguments are treated as strings for formats that are c, b or s. otherwise, it will be evaluated as a C constant with the extensions mentioned above. 

Also, if the number of arguments is bigger than the format specifications in the format string (%c, %b or %s for example), the format string will be reused as many times as needed. After consuming all the arguments. If there are still some format specification placeholders they will be replaced by null characters.

I am going to start by creating a main function to manually test my printf.

I want to build an executable that can be used to make simple tests for now (since the tests in francinette are failing badly). I will use this code:

```
#include <stdio.h>
#include "ft_printf.h"
#include <stdarg.h>

int	main(void)
{
	char	*str;
	int		num;

	num = 123;
	str = "Hello, World!";

	ft_printf("String:\t %s, Number: %d\n", str, num);
	printf("String:\t %s, Number: %d\n", str, num);

	return (0);
}

```

I also want to start using my libft function so I will modify the makefile to compile both the libft library and the main:

```
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
```

And a simple implementation of printf that will only printf the format string as it is:

```
int	ft_printf(char const *format, ...)
{
	while (*format != '\0')
	{
		ft_putchar_fd(*format, 1);
		format++;
	}
	return (0);
}
```

I can test with:

```
% make printf
cc -c -Wall -Wextra -Werror ft_printf.c -o ft_printf.o
cc -c -Wall -Wextra -Werror main.c -o main.o
ar -crs libftprintf.a ft_printf.o main.o
cc -Wall -Wextra -Werror -o printf main.c libftprintf.a libft/libft.a

% ./printf
String:	 %s, Number: %d
String:	 Hello, World!, Number: 123
```

Cool! We can start working on this!