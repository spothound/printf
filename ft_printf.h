/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_printf.h                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: fnavarro <fnavarro@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/09/15 21:01:58 by fnavarro          #+#    #+#             */
/*   Updated: 2023/11/20 18:22:23 by fnavarro         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef FT_PRINTF_H
# define FT_PRINTF_H 1

# include <stdlib.h>
# include <stdarg.h>
# include "libft.h"

int	ft_printf(char const *format, ...);

#endif