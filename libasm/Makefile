NAME = libasm.a

SRCS = srcs/ft_read.s srcs/ft_write.s \
	srcs/ft_strcmp.s srcs/ft_strcpy.s \
	srcs/ft_strdup.s srcs/ft_strlen.s

SRCSBONUS = ./srcs/ft_atoi_base.s			\
	./srcs/ft_list_push_front.s			\
	./srcs/ft_list_remove_if.s			\
	./srcs/ft_list_size.s			\
	./srcs/ft_list_sort.s			\

OBJ = $(SRCS:%.s=%.o)

OBJBONUS = $(SRCSBONUS:%.s=%.o)

%.o: %.s
	@nasm -f elf64 -D__LINUX__=1 $<

all: $(NAME)

$(NAME):	$(OBJ)
			@ar -rcs $(NAME) $(OBJ)
			ranlib $(NAME)

bonus:		$(OBJBONUS)
			@ar -rcs $(NAME) $(OBJBONUS)
			ranlib $(NAME)
clean:
			rm -rf $(OBJ) $(OBJBONUS)

fclean:		clean
			rm -f $(NAME)

re:			fclean	all

.PHONY:		all clean fclean re
