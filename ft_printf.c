/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_printf.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: fnavarro <fnavarro@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/11/07 17:11:00 by fnavarro          #+#    #+#             */
/*   Updated: 2023/11/20 18:47:56 by fnavarro         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_printf.h"

int	ft_printf(char const *format, ...)
{
	while (*format != '\0')
	{
		ft_putchar_fd(*format, 1);
		format++;
	}
	return (0);
}
