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

## FT_PRINTF.H

I will add the stdarg.h library to my `.h` to enable variadict functions.

Variadic functions are functions which may take a variable number of arguments and are declared with an ellipsis (...) in place of the last parameter. Printf is the most common example of variadic functions.

```
# include <stdarg.h>
```


## Printf prototype
The function prototype will be:

```
int	ft_printf(char const *format, ...)
{
	
}
```

- `The function return the number of characters printed (not including the trailing '\0' used to end output to strings)[FROM MAN]` as an integer (int).
- the `...` in the arguments represent that printf may take a variable number of arguments (is a variadic function).
